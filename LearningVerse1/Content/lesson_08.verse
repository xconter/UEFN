
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level

pawn := class():
    var TotalHP : int = 100
    var CurrentHP : int = 100

    TakeDamage(DamagePoints : int):void=
        set CurrentHP -= DamagePoints
    
    Heal(HealPoints : int):void=
        set CurrentHP += HealPoints
    
    IsAlive()<decides>:void=
        if (CurrentHP > 0) {true}
        else { false }

platform := class(pawn):
    PlatformProp : creative_prop = creative_prop{}
    StartingPos : vector3 = vector3{}
    EndingPos : vector3 = vector3{}

    Move():void=
        block:



lesson_08 := class(creative_device):

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        SomePawn := pawn{}
        SomePawn.TakeDamage(10)

        NewPlatform := platform{}
        NewPlatform.TakeDamage(10)

        set NewPlatform.CurrentHP = 1