if SAM_LOADED then return end

sam.command.set_category("ArsenicCredits")

sam.command.new("givecredits")
  :SetPermission("givecredits", "superadmin")
  :SetCategory("ArsenicCredits")
  :Help("Give credits to a player")

  :AddArg("player", {
    hint = "Player to give credits to",
    single_target = true,
    allow_higher_target = true,
  })

  :AddArg("number", {
    hint = "Number of credits to give",
    round = true
  })

  :OnExecute(function(calling_ply, player, number)
    if SERVER then
      PIXEL.Credits.DB.GiveCredits(player, number)
    end
    sam.player.send_message(nil, "{A} gave {T} '{V}' Credits", {
        A = calling_ply, T = player, V = number
    })
  end)
:End()

sam.command.new("removecredits")
  :SetPermission("removecredits", "superadmin")
  :SetCategory("ArsenicCredits")
  :Help("Give credits to a player")

  :AddArg("player", {
    hint = "Player to remove credits from",
    single_target = true,
    allow_higher_target = true,
  })

  :AddArg("number", {
    hint = "Number of credits to remove",
    round = true
  })

  :OnExecute(function(calling_ply, player, number)
    if SERVER then
      PIXEL.Credits.DB.GiveCredits(player, number)
    end
    sam.player.send_message(nil, "{A} removed '{V}' credits from {T}", {
        A = calling_ply, T = player, V = number
    })
  end)
:End()