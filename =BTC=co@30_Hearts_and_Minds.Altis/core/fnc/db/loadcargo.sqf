
/* ----------------------------------------------------------------------------
Function: btc_fnc_db_loadcargo

Description:
    Fill me when you edit me !

Parameters:
    _obj - []
    _cargo - []
    _inventory - []

Returns:

Examples:
    (begin example)
        _result = [] call btc_fnc_db_loadcargo;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

[{
    params ["_obj", "_cargo", "_inventory"];

    //handle cargo
    {
        _x params ["_type", "_magClass", "_cargo_obj"];

        private _l = createVehicle [_type, getPosATL _obj, [], 0, "CAN_COLLIDE"];
        [_l] call btc_fnc_log_init;
        private _isloaded = [_l, _obj] call ace_cargo_fnc_loadItem;
        if (btc_debug_log) then {
            [format ["Object loaded: %1 in veh/container %2 IsLoaded: %3", _l, _obj, _isloaded], __FILE__, [false]] call btc_fnc_debug_message;
        };

        if (_magClass != "") then {
            _l setVariable ["ace_rearm_magazineClass", _magClass, true]
        };

        [_l, _cargo_obj] call btc_fnc_log_setCargo;
    } forEach _cargo;

    //set inventory content for weapons, magazines and items
    [_obj, _inventory] call btc_fnc_log_setCargo;
}, _this] call CBA_fnc_waitAndExecute;
