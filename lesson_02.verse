
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
lesson_02 := class(creative_device):

    var PlayerTotalHealth : int = 100
    var EnemyAttackDamage : int = 10
    var PlayerDefense : int = 5
    var SpecialAttackDamage : float = 65.0
    var BaseAttackDamage : int = 20

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        Print("{PlayerTotalHealth}")
        set PlayerTotalHealth -= EnemyAttackDamage
        Print("{PlayerTotalHealth}")  

        set PlayerTotalHealth -= (EnemyAttackDamage - PlayerDefense)
        Print("{PlayerTotalHealth}")  
        HealthPotion : int = 20