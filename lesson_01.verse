
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
lesson_01 := class(creative_device):

    var PlayerName : string = "Enter Name Here"
    var TotalHealth : int = 100
    var AttackDamage : int = 100
    var TotalMoney : float = 0.0

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        Print(PlayerName)
        Print("Name: {PlayerName}")
        Print("Total Health: {TotalHealth}")
        Print("Attack Damage: {AttackDamage}")
        Print("Total Money : {TotalMoney}")
        set PlayerName = "Charlie"
        set TotalMoney = 45.6
        Print("Name : {PlayerName}")
        Print("Total Money: {TotalMoney}")