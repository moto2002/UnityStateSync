require "lfs"
local dir		= lfs.currentdir()

local protocols = dir .. "/protocols/"
local path_old	= package.path
package.path 	= string.format("%s?.lua;%s", protocols, path_old)


require "protocols/Protocols"
require "protocols/Msg"

require "network/net"
require "network/packet"

require "controller/TestController"


function sendTestXX()
	reqTestXX = ReqTestXX.new()
	reqTestXX:setIdU8(110)
	reqTestXX:setIdU16(111)
	reqTestXX:setIdU32(112)
	repU8Table = {}
	table.insert(repU8Table, 12)
	reqTestXX:setRepeatIdU8(repU8Table)
	reqTestXX:setOptionalIdU8(123)

	g_net:send(reqTestXX:encode())
end

function sendTestSend()
	roleBase 	= MsgRoleBase.new()
	roleBase:setUid(110)
	roleBase:setUname("mirahs")

	idF32Table = {}
	table.insert(idF32Table, 12.34)

	reqTestSend = ReqTestSend.new()
	reqTestSend:setIdU8(111)
	reqTestSend:setRoleBase(roleBase)
	reqTestSend:setIdF32(idF32Table)
	reqTestSend:setIdOpU8(123)
	reqTestSend:setOpRoleBase(roleBase)

	g_net:send(reqTestSend:encode())
end


g_net = net.new("127.0.0.1", 8888)
g_net:connect()

if g_net.client then
	print "connect to server success\n"

	-- 注册消息回调
	TestController:getInstance()

	sendTestXX()
	sendTestSend()
	
	-- 开始工作
	g_net:run()
end
