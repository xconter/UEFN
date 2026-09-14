using { /Verse.org/Simulation }
using { /Verse.org/Random }
using { /Verse.org/Verse }
using { /Fortnite.com/Game }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Devices }
using { /UnrealEngine.com/Temporary/Diagnostics }
 
gun_game := class(creative_device):
 
    @editable var WeaponList: []item_granter_device = array{}
 
    @editable ShuffleWeapons: logic = false
 
    @editable VisualTracker: tracker_device = tracker_device{}

    @editable TrackerTitle: string = "Weapons Left"
 
    @editable EndConditionsOn: logic = true
 
    @editable EndGameDevice: end_game_device = end_game_device{}

    @editable NPC : npc_spawner_device = npc_spawner_device{}
 
    MakeMessage<localizes>(Text : string) : message = "{Text}"

    var AgentMap: [agent]int = map{}
 
    OnBegin<override>()<suspends>: void =
        GameSetup()
        
    GameSetup(): void =
        GetPlayspace().PlayerAddedEvent().Subscribe(SetupPlayer)
        NPC.EliminatedEvent.Subscribe(OnNPCEliminated)
        if (ShuffleWeapons?):
            set WeaponList = Shuffle(WeaponList)
        AllPlayers := GetPlayspace().GetPlayers()
            for (Player : AllPlayers):
                SetupPlayer(Player)
    
    OnNPCEliminated(Result: device_ai_interaction_result):void =
        if (Instigator := Result.Source?):
            if (Player := player[Instigator]):
                Print("Player eliminated the NPC!")
                NextWeapon(Player)

    OnPlayerEliminated(Result: elimination_result): void =
        EliminatingCharacter := Result.EliminatingCharacter
        EliminatedCharacter := Result.EliminatedCharacter
        if:
            EliminatingFortCharacter := EliminatingCharacter?
            EliminatingAgent := EliminatingFortCharacter.GetAgent[]
            EliminatedFortCharacter := EliminatedCharacter
            EliminatedAgent := EliminatedFortCharacter.GetAgent[]
            EliminatedAgent <> EliminatingAgent
        then:
            NextWeapon(EliminatingAgent)
 
    SetupPlayer(Agent: agent): void =
        if (FortCharacter := Agent.GetFortCharacter[]):
            FortCharacter.EliminatedEvent().Subscribe(OnPlayerEliminated)
        if:
            not AgentMap[Agent]
            set AgentMap[Agent] = 0
        VisualTracker.Assign(Agent)
        VisualTracker.SetTarget(WeaponList.Length)
        VisualTracker.SetTitleText(MakeMessage(TrackerTitle))
        if (FirstItem := WeaponList[0]):
            FirstItem.GrantItem(Agent)
 
    NextWeapon(Agent: agent): void =
        if (var CurrentItemIndex : int = AgentMap[Agent]):
            set CurrentItemIndex += 1
            if (CurrentItemIndex = WeaponList.Length and EndConditionsOn?):
                EndGameDevice.Activate(Agent)
            else:
                if (NextItem := WeaponList[CurrentItemIndex]):
                    NextItem.GrantItem(Agent)
                    if {set AgentMap[Agent] = CurrentItemIndex}