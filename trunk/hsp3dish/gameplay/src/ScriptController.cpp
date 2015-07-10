#include "Base.h"
#include "FileSystem.h"
#include "ScriptController.h"

#ifndef NO_LUA_BINDINGS
#include "lua/lua_all_bindings.h"
#endif

#define GENERATE_LUA_GET_POINTER(type, checkFunc) ;

#define PUSH_NESTED_VARIABLE(name, defaultValue) ;

#define POP_NESTED_VARIABLE() ;

/**
 * Pushes onto the stack, the value of the global 'name' or the nested table value if 'name' is a '.' separated 
 * list of tables of the form "A.B.C.D", where A, B and C are tables and D is a variable name in the table C.
 * 
 * If 'name' does not contain any '.' then it is assumed to be the name of a global variable.
 * 
 * This function will not restore the stack if there is an error.
 * 
 * @param lua  The Lua state.
 * @param name The name of a global variable or a '.' separated list of nested tables ending with a variable name.
 *             The name value may be in the format "A.B.C.D" where A is a table and B, C are child tables.
 *             D is any type, which will be accessed by the calling function.
 * 
 * @return True if the tables were pushed on the stack or the global variable was pushed. Returns false on error.
 */
static bool getNestedVariable(lua_State* lua, const char* name)
{
    return false;
}

namespace gameplay
{

extern void splitURL(const std::string& url, std::string* file, std::string* id);

void ScriptUtil::registerLibrary(const char* name, const luaL_Reg* functions)
{
}

void ScriptUtil::registerConstantBool(const std::string& name, bool value, const std::vector<std::string>& scopePath)
{
}

void ScriptUtil::registerConstantNumber(const std::string& name, double value, const std::vector<std::string>& scopePath)
{
}

void ScriptUtil::registerConstantString(const std::string& name, const std::string& value, const std::vector<std::string>& scopePath)
{
}

void ScriptUtil::registerClass(const char* name, const luaL_Reg* members, lua_CFunction newFunction, 
    lua_CFunction deleteFunction, const luaL_Reg* statics,  const std::vector<std::string>& scopePath)
{
}

void ScriptUtil::registerFunction(const char* luaFunction, lua_CFunction cppFunction)
{
}

void ScriptUtil::setGlobalHierarchyPair(const std::string& base, const std::string& derived)
{
}

void ScriptUtil::addStringFromEnumConversionFunction(luaStringEnumConversionFunction stringFromEnum)
{
}

ScriptUtil::LuaArray<bool> ScriptUtil::getBoolPointer(int index)
{
    GENERATE_LUA_GET_POINTER(bool, luaCheckBool);
	return 0;
}

ScriptUtil::LuaArray<short> ScriptUtil::getShortPointer(int index)
{
    GENERATE_LUA_GET_POINTER(short, (short)luaL_checkint);
	return 0;
}

ScriptUtil::LuaArray<int> ScriptUtil::getIntPointer(int index)
{
    GENERATE_LUA_GET_POINTER(int, (int)luaL_checkint);
	return 0;
}

ScriptUtil::LuaArray<long> ScriptUtil::getLongPointer(int index)
{
    GENERATE_LUA_GET_POINTER(long, (long)luaL_checkint);
	return 0;
}

ScriptUtil::LuaArray<unsigned char> ScriptUtil::getUnsignedCharPointer(int index)
{
    GENERATE_LUA_GET_POINTER(unsigned char, (unsigned char)luaL_checkunsigned);
	return 0;
}

ScriptUtil::LuaArray<unsigned short> ScriptUtil::getUnsignedShortPointer(int index)
{
    GENERATE_LUA_GET_POINTER(unsigned short, (unsigned short)luaL_checkunsigned);
	return 0;
}

ScriptUtil::LuaArray<unsigned int> ScriptUtil::getUnsignedIntPointer(int index)
{
    GENERATE_LUA_GET_POINTER(unsigned int, (unsigned int)luaL_checkunsigned);
	return 0;
}

ScriptUtil::LuaArray<unsigned long> ScriptUtil::getUnsignedLongPointer(int index)
{
    GENERATE_LUA_GET_POINTER(unsigned long, (unsigned long)luaL_checkunsigned);
	return 0;
}

ScriptUtil::LuaArray<float> ScriptUtil::getFloatPointer(int index)
{
    GENERATE_LUA_GET_POINTER(float, (float)luaL_checknumber);
	return 0;
}

ScriptUtil::LuaArray<double> ScriptUtil::getDoublePointer(int index)
{
    GENERATE_LUA_GET_POINTER(double, (double)luaL_checknumber);
	return 0;
}

const char* ScriptUtil::getString(int index, bool isStdString)
{
        return NULL;
}

bool ScriptUtil::luaCheckBool(lua_State* state, int n)
{
        return false;
}


void ScriptController::loadScript(const char* path, bool forceReload)
{
}

std::string ScriptController::loadUrl(const char* url)
{
    std::string file;
    std::string id;
    splitURL(url, &file, &id);

    // Make sure the function isn't empty.
    if (id.size() <= 0)
    {
        GP_ERROR("Got an empty function name when parsing function url '%s'.", url);
        return std::string();
    }

    // Ensure the script is loaded.
    if (file.size() > 0)
        Game::getInstance()->getScriptController()->loadScript(file.c_str());

    // Return the function name.
    return id;
}

bool ScriptController::getBool(const char* name, bool defaultValue)
{
    return false;
}

char ScriptController::getChar(const char* name, char defaultValue)
{
    return 0;
}

short ScriptController::getShort(const char* name, short defaultValue)
{
    return 0;
}

int ScriptController::getInt(const char* name, int defaultValue)
{
    return 0;
}

long ScriptController::getLong(const char* name, long defaultValue)
{
    return 0;
}

unsigned char ScriptController::getUnsignedChar(const char* name, unsigned char defaultValue)
{
    return 0;
}

unsigned short ScriptController::getUnsignedShort(const char* name, unsigned short defaultValue)
{
    return 0;
}

unsigned int ScriptController::getUnsignedInt(const char* name, unsigned int defaultValue)
{
    return 0;
}

unsigned long ScriptController::getUnsignedLong(const char* name, unsigned long defaultValue)
{
    return 0;
}

float ScriptController::getFloat(const char* name, float defaultValue)
{
    return 0.0f;
}

double ScriptController::getDouble(const char* name, double defaultValue)
{
    return 0.0;
}

const char* ScriptController::getString(const char* name)
{
    return NULL;
}

void ScriptController::setBool(const char* name, bool v)
{
}

void ScriptController::setChar(const char* name, char v)
{
}

void ScriptController::setShort(const char* name, short v)
{
}

void ScriptController::setInt(const char* name, int v)
{
}

void ScriptController::setLong(const char* name, long v)
{
}

void ScriptController::setUnsignedChar(const char* name, unsigned char v)
{
}

void ScriptController::setUnsignedShort(const char* name, unsigned short v)
{
}

void ScriptController::setUnsignedInt(const char* name, unsigned int v)
{
}

void ScriptController::setUnsignedLong(const char* name, unsigned long v)
{
}

void ScriptController::setFloat(const char* name, float v)
{
}

void ScriptController::setDouble(const char* name, double v)
{
}

void ScriptController::setString(const char* name, const char* v)
{
}

void ScriptController::print(const char* str)
{
}

void ScriptController::print(const char* str1, const char* str2)
{
}

ScriptController::ScriptController() : _lua(NULL)
{
}

ScriptController::~ScriptController()
{
}

static const char* lua_print_function = 
    "function print(...)\n"
    "    ScriptController.print(table.concat({...},\"\\t\"), \"\\n\")\n"
    "end\n";

static const char* lua_loadfile_function = 
    "do\n"
    "    local oldLoadfile = loadfile\n"
    "    loadfile = function(filename)\n"
    "        if filename ~= nil and not FileSystem.isAbsolutePath(filename) then\n"
    "            FileSystem.createFileFromAsset(filename)\n"
    "            filename = FileSystem.getResourcePath() .. filename\n"
    "        end\n"
    "        return oldLoadfile(filename)\n"
    "    end\n"
    "end\n";

static const char* lua_dofile_function = 
    "do\n"
    "    local oldDofile = dofile\n"
    "    dofile = function(filename)\n"
    "        if filename ~= nil and not FileSystem.isAbsolutePath(filename) then\n"
    "            FileSystem.createFileFromAsset(filename)\n"
    "            filename = FileSystem.getResourcePath() .. filename\n"
    "        end\n"
    "        return oldDofile(filename)\n"
    "    end\n"
    "end\n";

/**
 * @script{ignore}
 */
void appendLuaPath(lua_State* state, const char* path)
{
}

void ScriptController::initialize()
{
}

void ScriptController::initializeGame()
{
}

void ScriptController::finalize()
{
}

void ScriptController::finalizeGame()
{
}

void ScriptController::update(float elapsedTime)
{
}

void ScriptController::render(float elapsedTime)
{
}

void ScriptController::resizeEvent(unsigned int width, unsigned int height)
{
}

void ScriptController::keyEvent(Keyboard::KeyEvent evt, int key)
{
}

void ScriptController::touchEvent(Touch::TouchEvent evt, int x, int y, unsigned int contactIndex)
{
}

bool ScriptController::mouseEvent(Mouse::MouseEvent evt, int x, int y, int wheelDelta)
{
    return false;
}

void ScriptController::gestureSwipeEvent(int x, int y, int direction)
{
}

void ScriptController::gesturePinchEvent(int x, int y, float scale)
{
}

void ScriptController::gestureTapEvent(int x, int y)
{
}

void ScriptController::gamepadEvent(Gamepad::GamepadEvent evt, Gamepad* gamepad, unsigned int analogIndex)
{
}

void ScriptController::executeFunctionHelper(int resultCount, const char* func, const char* args, va_list* list)
{
}

void ScriptController::registerCallback(const char* callback, const char* function)
{
}

void ScriptController::unregisterCallback(const char* callback, const char* function)
{
}

ScriptController::ScriptCallback ScriptController::toCallback(const char* name)
{
    return ScriptController::INVALID_CALLBACK;
}

int ScriptController::convert(lua_State* state)
{
    return 0;
}

// Helper macros.
#define SCRIPT_EXECUTE_FUNCTION_NO_PARAM(type, checkfunc) \
    type value = (type)0; \
    return value;

#define SCRIPT_EXECUTE_FUNCTION_PARAM(type, checkfunc) \
    type value = (type)0; \
    return value;

#define SCRIPT_EXECUTE_FUNCTION_PARAM_LIST(type, checkfunc) \
    type value = (type)0; \
    return value;

template<> void ScriptController::executeFunction<void>(const char* func)
{
}

template<> bool ScriptController::executeFunction<bool>(const char* func)
{
    SCRIPT_EXECUTE_FUNCTION_NO_PARAM(bool, ScriptUtil::luaCheckBool);
}

template<> char ScriptController::executeFunction<char>(const char* func)
{
    SCRIPT_EXECUTE_FUNCTION_NO_PARAM(char, luaL_checkint);
}

template<> short ScriptController::executeFunction<short>(const char* func)
{
    SCRIPT_EXECUTE_FUNCTION_NO_PARAM(short, luaL_checkint);
}

template<> int ScriptController::executeFunction<int>(const char* func)
{
    SCRIPT_EXECUTE_FUNCTION_NO_PARAM(int, luaL_checkint);
}

template<> long ScriptController::executeFunction<long>(const char* func)
{
    SCRIPT_EXECUTE_FUNCTION_NO_PARAM(long, luaL_checklong);
}

template<> unsigned char ScriptController::executeFunction<unsigned char>(const char* func)
{
    SCRIPT_EXECUTE_FUNCTION_NO_PARAM(unsigned char, luaL_checkunsigned);
}

template<> unsigned short ScriptController::executeFunction<unsigned short>(const char* func)
{
    SCRIPT_EXECUTE_FUNCTION_NO_PARAM(unsigned short, luaL_checkunsigned);
}

template<> unsigned int ScriptController::executeFunction<unsigned int>(const char* func)
{
    SCRIPT_EXECUTE_FUNCTION_NO_PARAM(unsigned int, luaL_checkunsigned);
}

template<> unsigned long ScriptController::executeFunction<unsigned long>(const char* func)
{
    SCRIPT_EXECUTE_FUNCTION_NO_PARAM(unsigned long, luaL_checkunsigned);
}

template<> float ScriptController::executeFunction<float>(const char* func)
{
    SCRIPT_EXECUTE_FUNCTION_NO_PARAM(float, luaL_checknumber);
}

template<> double ScriptController::executeFunction<double>(const char* func)
{
    SCRIPT_EXECUTE_FUNCTION_NO_PARAM(double, luaL_checknumber);
}

template<> std::string ScriptController::executeFunction<std::string>(const char* func)
{
    SCRIPT_EXECUTE_FUNCTION_NO_PARAM(std::string, luaL_checkstring);
}

/** Template specialization. */
template<> void ScriptController::executeFunction<void>(const char* func, const char* args, ...)
{
}

/** Template specialization. */
template<> bool ScriptController::executeFunction<bool>(const char* func, const char* args, ...)
{
    SCRIPT_EXECUTE_FUNCTION_PARAM(bool, ScriptUtil::luaCheckBool);
}

/** Template specialization. */
template<> char ScriptController::executeFunction<char>(const char* func, const char* args, ...)
{
    SCRIPT_EXECUTE_FUNCTION_PARAM(char, luaL_checkint);
}

/** Template specialization. */
template<> short ScriptController::executeFunction<short>(const char* func, const char* args, ...)
{
    SCRIPT_EXECUTE_FUNCTION_PARAM(short, luaL_checkint);
}

/** Template specialization. */
template<> int ScriptController::executeFunction<int>(const char* func, const char* args, ...)
{
    SCRIPT_EXECUTE_FUNCTION_PARAM(int, luaL_checkint);
}

/** Template specialization. */
template<> long ScriptController::executeFunction<long>(const char* func, const char* args, ...)
{
    SCRIPT_EXECUTE_FUNCTION_PARAM(long, luaL_checklong);
}

/** Template specialization. */
template<> unsigned char ScriptController::executeFunction<unsigned char>(const char* func, const char* args, ...)
{
    SCRIPT_EXECUTE_FUNCTION_PARAM(unsigned char, luaL_checkunsigned);
}

/** Template specialization. */
template<> unsigned short ScriptController::executeFunction<unsigned short>(const char* func, const char* args, ...)
{
    SCRIPT_EXECUTE_FUNCTION_PARAM(unsigned short, luaL_checkunsigned);
}

/** Template specialization. */
template<> unsigned int ScriptController::executeFunction<unsigned int>(const char* func, const char* args, ...)
{
    SCRIPT_EXECUTE_FUNCTION_PARAM(unsigned int, luaL_checkunsigned);
}

/** Template specialization. */
template<> unsigned long ScriptController::executeFunction<unsigned long>(const char* func, const char* args, ...)
{
    SCRIPT_EXECUTE_FUNCTION_PARAM(unsigned long, luaL_checkunsigned);
}

/** Template specialization. */
template<> float ScriptController::executeFunction<float>(const char* func, const char* args, ...)
{
    SCRIPT_EXECUTE_FUNCTION_PARAM(float, luaL_checknumber);
}

/** Template specialization. */
template<> double ScriptController::executeFunction<double>(const char* func, const char* args, ...)
{
    SCRIPT_EXECUTE_FUNCTION_PARAM(double, luaL_checknumber);
}

/** Template specialization. */
template<> std::string ScriptController::executeFunction<std::string>(const char* func, const char* args, ...)
{
    SCRIPT_EXECUTE_FUNCTION_PARAM(std::string, luaL_checkstring);
}

/** Template specialization. */
template<> void ScriptController::executeFunction<void>(const char* func, const char* args, va_list* list)
{
    executeFunctionHelper(0, func, args, list);
}

/** Template specialization. */
template<> bool ScriptController::executeFunction<bool>(const char* func, const char* args, va_list* list)
{
    SCRIPT_EXECUTE_FUNCTION_PARAM_LIST(bool, ScriptUtil::luaCheckBool);
}

/** Template specialization. */
template<> char ScriptController::executeFunction<char>(const char* func, const char* args, va_list* list)
{
    SCRIPT_EXECUTE_FUNCTION_PARAM_LIST(char, luaL_checkint);
}

/** Template specialization. */
template<> short ScriptController::executeFunction<short>(const char* func, const char* args, va_list* list)
{
    SCRIPT_EXECUTE_FUNCTION_PARAM_LIST(short, luaL_checkint);
}

/** Template specialization. */
template<> int ScriptController::executeFunction<int>(const char* func, const char* args, va_list* list)
{
    SCRIPT_EXECUTE_FUNCTION_PARAM_LIST(int, luaL_checkint);
}

/** Template specialization. */
template<> long ScriptController::executeFunction<long>(const char* func, const char* args, va_list* list)
{
    SCRIPT_EXECUTE_FUNCTION_PARAM_LIST(long, luaL_checklong);
}

/** Template specialization. */
template<> unsigned char ScriptController::executeFunction<unsigned char>(const char* func, const char* args, va_list* list)
{
    SCRIPT_EXECUTE_FUNCTION_PARAM_LIST(unsigned char, luaL_checkunsigned);
}

/** Template specialization. */
template<> unsigned short ScriptController::executeFunction<unsigned short>(const char* func, const char* args, va_list* list)
{
    SCRIPT_EXECUTE_FUNCTION_PARAM_LIST(unsigned short, luaL_checkunsigned);
}

/** Template specialization. */
template<> unsigned int ScriptController::executeFunction<unsigned int>(const char* func, const char* args, va_list* list)
{
    SCRIPT_EXECUTE_FUNCTION_PARAM_LIST(unsigned int, luaL_checkunsigned);
}

/** Template specialization. */
template<> unsigned long ScriptController::executeFunction<unsigned long>(const char* func, const char* args, va_list* list)
{
    SCRIPT_EXECUTE_FUNCTION_PARAM_LIST(unsigned long, luaL_checkunsigned);
}

/** Template specialization. */
template<> float ScriptController::executeFunction<float>(const char* func, const char* args, va_list* list)
{
    SCRIPT_EXECUTE_FUNCTION_PARAM_LIST(float, luaL_checknumber);
}

/** Template specialization. */
template<> double ScriptController::executeFunction<double>(const char* func, const char* args, va_list* list)
{
    SCRIPT_EXECUTE_FUNCTION_PARAM_LIST(double, luaL_checknumber);
}

/** Template specialization. */
template<> std::string ScriptController::executeFunction<std::string>(const char* func, const char* args, va_list* list)
{
    SCRIPT_EXECUTE_FUNCTION_PARAM_LIST(std::string, luaL_checkstring);
}

}
