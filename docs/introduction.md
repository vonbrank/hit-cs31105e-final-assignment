
# 乒乓球比赛模拟机设计

## 需求

## 实现

+ 流程图

![structure](img/structure.drawio.png)

+ 组件说明
  + 全局状态控制器`GameController`

    用于控制整个模拟器各组件状态。

    + 输入：
      + `CLK`：时钟，上升沿触发。
      + ``：
      + `hitSuccess`：击球信号。`01`击球成功，`10`击球失败，`00`或`11`尚未击球或发球。
      + `serviceSide`：发球方。`0`表示`A`玩家，`1`表示`B`玩家
      + `reset`：重置比赛

    + 输出：
      + `status [2:0]`：`010`表示`A`发球，`001`表示`B`发球，`110`表示玩家`A`接球，`101`表示玩家`B`接球。
  
    上电时，`status`初始化为`010`。

    有状态表。

    | status | hitSuccess  | 01  | 01  | 10  | 10  | 00  | 11  |
    |--------|-------------|-----|-----|-----|-----|-----|-----|
    |        | serviceSide | 0   | 1   | 0   | 1   | x   | x   |
    | 010    |             | 101 | 101 | 010 | 010 | 010 | 010 |
    | 001    |             | 110 | 110 | 001 | 001 | 001 | 001 |
    | 110    |             | 101 | 101 | 010 | 001 | 110 | 110 |
    | 101    |             | 110 | 110 | 010 | 001 | 101 | 101 |

  + 乒乓球运动控制器 `BallController`

    控制乒乓球运动。

    + 输入：
      + `CLK`：时钟，上升沿触发。
      + `hit`：玩家击球信号。两次击球信号的上升沿距离过近，后一次将失效，模拟击球存在`CD`，击球`CD`与速度负相关。
      + `ballSpeed [1:0]`：击球速度。`00~11`分别表示`1~4`档速度。
      + `status [2:0]`：`010`表示`A`发球，`001`表示`B`发球，`110`表示玩家`A`接球，`101`表示玩家`接球`。

    + 输出：
      + `currentResult [1:0]`：本轮局势。`10`表示`A`得分，`01`表示`B`得分，`00`或`11`保持。
      + `hitSuccess`：击球信号。`01`击球成功，`10`击球失败，`00`或`11`尚未击球或发球。
      + `ballLocation [7:0]`：球的位置，第`i`位为`1`表示球在第`i`个位置。
    + 寄存器：
      + `accurateBallLocation [32:0]`：球的精确位置，范围为十进制`0-8000`

    `currentResult, hitSuccess`默认为`00`或`11`，下文的参数`k`需要实地调试才能得到，`m`是与`ballSpeed`负相关的参数。

    `status`为`010`时`accurateBallLocation = 8000`

    `status`为`001`时`accurateBallLocation = 0`

    `status`为`110`时`accurateBallLocation`每`CLK`增加`ballSpeed * k`

    `status`为`101`时`accurateBallLocation`每`CLK`减少`ballSpeed * k`

    `status`为`010`时`hit`上升沿将`hitSuccess`转换为`01`

    `status`为`001`时`hit`上升沿将`hitSuccess`转换为`01`

    `status`为`110`时，`accurateBallLocation = 0`将`hitSuccess`转换为`10`，`currentResult`转换为`01`

    `status`为`110`时，`accurateBallLocation = 0`将`hitSuccess`转换为`10`，`currentResult`转换为`10`

    `status`为`110`时，有效的`hit`上升沿且`accurateBallLocation`在`0 ~ 1000 * m`将`hitSuccess`转换为`10`

    `status`为`101`时，有效的`hit`上升沿且`accurateBallLocation`在`(8000 - 1000 * m) ~ 8000`将`status`转换为`10`

  + 玩家控制器 `Player`

    控制玩家输入与接发球操作。

    + 输入：
      + `CLK`：时钟，上升沿触发。
      + `EN`：玩家使能，轮到该玩家发球或接球时有效。
      + `hit`：连接开关，高电平有效，表面玩家做出击球动作。
      + `speed [1:0]`：该玩家期望的击球速度。
    + 输出：
      + `hitOut`：该玩家击球。
      + `speedOut [1:0]`：该玩家期望的击球速度。
  
    `EN`有效时，把`hit`和`speed`传递给`hitOut`和`speedOut`

  + 分数控制器 `ScoreBoard`

      记录玩家分数。

    + 输入：
      + `CLK`：时钟，上升沿触发。
      + `currentResult [1:0]`：本轮局势。`10`表示`A`得分，`01`表示`B`得分，`00`或`11`保持。
    + 输出：
      + `scoreA [3:0]`：玩家`A`的得分。
      + `scoreB [3:0]`：玩家`B`的得分。
      + `serviceSide`：发球方。`0`表示`A`玩家，`1`表示`B`玩家
      + `endGame`：记满`11`分，游戏结束。
      + `winner [1:0]`：游戏结束时，获胜的玩家，`10`为`A`，`01`为`B`，其他情况平局。

     `serviceSide, endGame`初始化为`0`

    每个`currentResult[1]`的上升沿`scoreA+1`

    每个`currentResult[0]`的上升沿`scoreB+1`

    `scoreA + scoreB > 5`时`currentResult = 1`

    `scoreA + scoreB = 11`时`endGame = 1`

    `endGame = 1`时，`scoreA < scoreB`则`winner = 10`，`scoreA 》 scoreB`则`winner = 01`，否则`winner = 00 或 11`

  + 分数显示器 `ScoreDisplay`

    显示当前信息

    + 输入：
      + `scoreA [3:0]`：玩家`A`的得分。
      + `scoreB [3:0]`：玩家`B`的得分。
      + `serviceSide`：发球方。`0`表示`A`玩家，`1`表示`B`玩家
      + `endGame`：记满`11`分，游戏结束。
      + `winner`：游戏结束时，获胜的玩家，`0`为`A`，`1`为`B`。
      + `status [2:0]`：`010`表示`A`发球，`001`表示`B`发球，`110`表示玩家`A`接球，`101`表示玩家`B`接球。
      + `ballLocation [7:0]`：球的位置，第`i`位为`1`表示球在第`i`个位置。
    + 输出：
      + `display [63:0]`：八个八段数码管的信号，显示赛况。
      + `track [7:0]`：八个LED信号，显示球的位置。
      + `serviceSideLED [1:0]`：显示发球方。
