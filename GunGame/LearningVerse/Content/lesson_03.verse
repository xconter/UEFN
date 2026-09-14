
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Random }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
lesson_03 := class(creative_device):

    var PlayerHealth : int = 100
    var EnemyAttackDamage : int = 51

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        Print("Enemy Attacks Player")
        set PlayerHealth -= EnemyAttackDamage

        if (PlayerHealth <= 0):
            Print("Player Died")

        Print("Player flinched. Enemy Attacks again")
        set PlayerHealth -= EnemyAttackDamage

        if (PlayerHealth <= 0):
            Print("Player Died")
            
        var PlayerDiceResult : int = GetRandomInt(1, 20)
        var EnemyDiceResult : int = GetRandomInt(1, 20)

        set PlayerHealth = 100
        Print("Player and enemy rolled dice")
        Print("Player Dice: {PlayerDiceResult}")
        Print("Enemy Dice: {EnemyDiceResult}")

        if (EnemyDiceResult > PlayerDiceResult):
            set PlayerHealth -= EnemyAttackDamage
            Print("Enemy Attack Successful! Player HP is now : {PlayerHealth}")
        else if (EnemyDiceResult = PlayerDiceResult):
            set PlayerHealth -= 1
            Print("Rolled Tie. Player lost 1 HP")
        else:
            Print("Enemy missed")
        
        if:
            EnemyDiceResult > PlayerDiceResult
            PlayerHealth>50
        then:
            set PlayerHealth -= EnemyAttackDamage
        else:
            Print("Enemy missed")