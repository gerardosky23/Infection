
--[[---------------------------------------------------------

  This file should contain variables and functions that are
   the same on both client and server.

  This file will get sent to the client - so don't add
   anything to this file that you don't want them to be
   able to see.

-----------------------------------------------------------]]


include( 'player_class/player_healthy.lua' )
include( 'player_class/player_infected.lua' )
include( 'player_class/taunt_camera.lua' )

GM.Name			= "Infection"
GM.Author		= "Genghis John"
GM.Email		= "john@GenghisJohn.com"
GM.Website		= "www.garry.tv"
GM.TeamBased	= false

resource.AddFile("sound/sneeze.wav")
resource.AddFile("sound/cough.wav")
resource.AddFile("particles/cough.pcf")

if CLIENT then
	game.AddParticles("particles/cough.pcf")
end
PrecacheParticleSystem("cough")


--[[---------------------------------------------------------
   Name: gamemode:KeyPress( )
   Desc: Player pressed a key (see IN enums)
-----------------------------------------------------------]]
function GM:KeyPress( player, key )
end

--[[---------------------------------------------------------
   Name: gamemode:KeyRelease( )
   Desc: Player released a key (see IN enums)
-----------------------------------------------------------]]
function GM:KeyRelease( player, key )
end

--[[---------------------------------------------------------
   Name: gamemode:PlayerConnect( )
   Desc: Player has connects to the server (hasn't spawned)
-----------------------------------------------------------]]
function GM:PlayerConnect( name, address )
end

--[[---------------------------------------------------------
   Name: gamemode:PropBreak( )
   Desc: Prop has been broken
-----------------------------------------------------------]]
function GM:PropBreak( attacker, prop )
	print(attacker:Nick().." Broke the ".. prop)
end



--[[---------------------------------------------------------
   Name: Text to show in the server browser
-----------------------------------------------------------]]
function GM:GetGameDescription()
	return self.Name
end

--[[---------------------------------------------------------
   Name: Saved
-----------------------------------------------------------]]
function GM:Saved()
end

--[[---------------------------------------------------------
   Name: Restored
-----------------------------------------------------------]]
function GM:Restored()
end

--[[---------------------------------------------------------
   Name: EntityRemoved
   Desc: Called right before an entity is removed. Note that this
   isn't going to be totally reliable on the client since the client
   only knows about entities that it has had in its PVS.
-----------------------------------------------------------]]
function GM:EntityRemoved( ent )
end

--[[---------------------------------------------------------
   Name: Tick
   Desc: Like Think except called every tick on both client and server
-----------------------------------------------------------]]
function GM:Tick()
end

--[[---------------------------------------------------------
   Name: OnEntityCreated
   Desc: Called right after the Entity has been made visible to Lua
-----------------------------------------------------------]]
function GM:OnEntityCreated( Ent )
end

--[[---------------------------------------------------------
   Name: gamemode:EntityKeyValue( ent, key, value )
   Desc: Called when an entity has a keyvalue set
		 Returning a string it will override the value
-----------------------------------------------------------]]
function GM:EntityKeyValue( ent, key, value )
end



--[[---------------------------------------------------------
   Name: gamemode:ShouldCollide( Ent1, Ent2 )
   Desc: This should always return true unless you have
		  a good reason for it not to.
-----------------------------------------------------------]]
function GM:ShouldCollide( Ent1, Ent2 )

	return true

end

--[[---------------------------------------------------------
   Name: gamemode:Move
   This basically overrides the NOCLIP, PLAYERMOVE movement stuff.
   It's what actually performs the move.
   Return true to not perform any default movement actions. (completely override)
-----------------------------------------------------------]]
function GM:Move( ply, mv )

	if ( drive.Move( ply, mv ) ) then return true end
	if ( player_manager.RunClass( ply, "Move", mv ) ) then return true end

end

--[[---------------------------------------------------------
-- Purpose: This is called pre player movement and copies all the data necessary
--          from the player for movement. Copy from the usercmd to move.
-----------------------------------------------------------]]
function GM:SetupMove( ply, mv, cmd )

	if ( drive.StartMove( ply, mv, cmd ) ) then return true end
	if ( player_manager.RunClass( ply, "StartMove", mv, cmd ) ) then return true end

end

--[[---------------------------------------------------------
   Name: gamemode:FinishMove( player, movedata )
-----------------------------------------------------------]]
function GM:FinishMove( ply, mv )

	if ( drive.FinishMove( ply, mv ) ) then return true end
	if ( player_manager.RunClass( ply, "FinishMove", mv ) ) then return true end

end

--[[---------------------------------------------------------
	Called after the player's think.
-----------------------------------------------------------]]
function GM:PlayerPostThink( ply )

end

--[[---------------------------------------------------------
	A player has started driving an entity
-----------------------------------------------------------]]
function GM:StartEntityDriving( ent, ply )

	drive.Start( ply, ent )

end

--[[---------------------------------------------------------
	A player has stopped driving an entity
-----------------------------------------------------------]]
function GM:EndEntityDriving( ent, ply )

	drive.End( ply, ent )

end

--[[---------------------------------------------------------
	To update the player's animation during a drive
-----------------------------------------------------------]]
function GM:PlayerDriveAnimate( ply )

end

--[[---------------------------------------------------------
	The gamemode has been reloaded
-----------------------------------------------------------]]
function GM:OnReloaded()
end

function GM:PreGamemodeLoaded()
end

function GM:OnGamemodeLoaded()
end

function GM:PostGamemodeLoaded()
end

--
-- Name: GM:OnViewModelChanged
-- Desc: Called when the player changes their weapon to another one - and their viewmodel model changes
-- Arg1: Entity|viewmodel|The viewmodel that is changing
-- Arg2: string|old|The old model
-- Arg3: string|new|The new model
-- Ret1:
--
function GM:OnViewModelChanged( vm, old, new )

	local ply = vm:GetOwner()
	if ( IsValid( ply ) ) then
		player_manager.RunClass( ply, "ViewModelChanged", vm, old, new )
	end

end

--[[---------------------------------------------------------
	Disable properties serverside for all non-sandbox derived gamemodes.
-----------------------------------------------------------]]
function GM:CanProperty( pl, property, ent )
	return false
end
