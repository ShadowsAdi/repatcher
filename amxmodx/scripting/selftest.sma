#include <amxmodx>
#include <repatcher>

public plugin_init()
{
	switch(rp_get_system())
	{
		case System_Windows:
		{
			server_print("Windows")
		}
		case System_Linux:
		{
			server_print("Linux")
		}
	}
	new Lib:iLib, iAddress
	if((iLib = rp_find_library("swds.dll")) == Invalid_Library)
	{
		server_print("Invalid library")
	}
	else
	{
		server_print("Found library %d", iLib)
	}

	if((iAddress = rp_find_signature(iLib, "55 8B ? 6A ? 68 52 14")) == 0)
	{
		server_print("Invalid signature")
	}
	else 
	{
		server_print("Found signature, %d", iAddress)
	}
	new Hook:i
	if((i = rp_add_hook(iAddress, "void __cdecl SV_ConnectClient_internal()", "SV_ConnectClient_internal", true)) == Hook:0)
	{
		server_print("Invalid hook")
	}
	else 
	{
		server_print("Found hook %d", i)
	}
	new szError[256]
	rp_get_error(szError, charsmax(szError))
	server_print("error: %s", szError)
}

public SV_ConnectClient_internal()
{
	server_print("called SV_ConnectClient_internal")
}