print("SV Loaded")

require( "mysqloo" )
assert( mysqloo, "[Poll] MySQLoo is not installed" )

local DATABASE_HOST = "localhost"
local DATABASE_PORT = 3306             
local DATABASE_NAME = "cloth_sys"    
local DATABASE_USERNAME = "root"      
local DATABASE_PASSWORD = "root"       
 
function connectToDatabasePollSystem()
	databaseObject = mysqloo.connect(DATABASE_HOST, DATABASE_USERNAME, DATABASE_PASSWORD, DATABASE_NAME, DATABASE_PORT)
	databaseObject.onConnected = function() print(" DataBase was found!") end
	databaseObject.onConnectionFailed = function() print("Failed to connect to the database.") end
	databaseObject:connect()
end

connectToDatabasePollSystem()


hook.Add('DarkRPDBInitialized', 'er.poll.system', function()
    local query1 = databaseObject:query([[
        CREATE TABLE IF NOT EXISTS soft_exp(
            id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
            steamID VARCHAR(30) NOT NULL,
			answer BOOLEAN NOT NULL,
            textEnryStr TEXT NOT NULL
        );
    ]])
    query1.onError = function(q,e) print("query error, maybe database or table not created or query is wrong") end
    query1:start()
end)


function checkPlyPollSystem(query)
    local playerInfo = query:getData()
    if playerInfo[1] ~= nil then
	return true
    else
	return false
    end
end

function PlayerBuyExpBust(ply, bustTime, bustName)
    local query1 = databaseObject:query("SELECT * FROM poll_system WHERE steamID = '" .. ply .. "'")
    query1.onSuccess = function(q)
        if not checkPlyPollSystem(q) then
            local strTextEnry = util.TableToJson(all_send_question)
			local BollSymbols = util.TableToJson(boolList)
            local query2 = databaseObject:query("INSERT INTO poll_system(steamID, answer, textEnryStr) VALUES ('" .. ply .. "','"..strTextEnry.."','"..BollSymbols.."')")
            query2.onSuccess = function(q)  print("Created User!") end
            query2.onError = function(q,e) print("Create Error")
            print(e) end
            query2:start()	
        else
            print("User Already Created!")
            return true
        end
    end
    query1.onError = function(q,e) print(e) print("query error, maybe database or table not created or query is wrong") end
    query1:start()
end

function CheckPlayerSoftExpInfo( ply )
    local query1 = databaseObject:query("SELECT * FROM poll_system WHERE steam = '" .. ply:SteamID() .. "'")
    query1.onSuccess = function(q)
        if not checkPlyPollSystem(q) then
            print("User dont have account")
        else
            print("User Already Created!")
            return true
        end
    end
    query1.onError = function(q,e) print("query error, maybe database or table not created or query is wrong") end
    query1:start()
end
hook.Add( "PlayerInitialSpawn", "PlayerInitialSpawn", CheckPlayerSoftExpInfo )