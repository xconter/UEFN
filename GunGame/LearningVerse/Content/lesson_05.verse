
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Random }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
lesson_05 := class(creative_device):
    #Properties
    var EnemyHP : int = 100
    var PlayerHP : int = 100

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        StartGame()

    
    StartGame() : void =
        loop:
            AttackEnemy()
            EnemyAttackPlayer()
            Fighting := IsBattleInProgress()
            if (Fighting = false) { break }
        
        set PlayerHP += GenerateRandomHealthPotion()
        Print("Player Health: {PlayerHP}")

    AttackEnemy() : void=
        set EnemyHP -= GetRandomInt(1,10)
        Print("Enemy HP: {EnemyHP}")

    EnemyAttackPlayer() : void=
        set PlayerHP -= GetRandomInt(1,10)
        Print("Player HP: {PlayerHP}")
    
    IsBattleInProgress() : logic=
        if (EnemyHP <= 0):
            Print("Player defeated enemy")
            return false
        else if (PlayerHP <= 0):
            Print("The enemy has defeated the player")
            return false
        else:
            Print("The battle continues")
            return true
    
    GenerateRandomHealthPotion() : int =
        return GetRandomInt(10,50)