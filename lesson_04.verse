
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Random }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
lesson_04 := class(creative_device):

    var PlayerHealth : int = 100
    var EnemyHealth : int = 100
    var AttackDamage : int = 11

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        var Iteration : int = 0
        loop:
            set Iteration += 1
            Print("Loop: {Iteration}")
            var PlayerDiceResult : int = GetRandomInt(1,20)
            var EnemyDiceResult : int = GetRandomInt(1,20)
            Print("Player Dice: {PlayerDiceResult}")
            Print("Enemy Dice: {EnemyDiceResult}")

            if (EnemyDiceResult > PlayerDiceResult):
                set PlayerHealth -= AttackDamage
                Print("Enemy Attack Successful!")
            else if (EnemyDiceResult = PlayerDiceResult):
                set PlayerHealth -= 1
                Print("Rolled Tie. Player lost 1 HP")
            else:
                set EnemyHealth -= AttackDamage
                Print("Player Attack Successful!")
            if (PlayerHealth <= 0):
                Print("Player Died")
                break
            else if (EnemyHealth <= 0):
                Print("Enemy Died")
                break
        
        var IDX : int = 0 
        loop:
            if (IDX > 10):
                break
            set IDX += 1

        for (X : int = 1..10):
            Print("Index: {X}")