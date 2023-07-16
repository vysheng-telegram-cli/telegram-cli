cmake_minimum_required(VERSION 3.18 FATAL_ERROR)

project(telegram-cli C)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

find_package(OpenSSL REQUIRED COMPONENTS Crypto SSL)
find_package(ZLIB REQUIRED)
find_package(Lua REQUIRED)
find_package(Threads REQUIRED)
find_package(Jannson REQUIRED)
find_package(Readline REQUIRED)
find_package(LibConfig REQUIRED)

add_subdirectory(ThirdParty/tgl)

add_executable(${PROJECT_NAME}
	src/main.c
	src/loop.c
	src/interface.c
	src/lua-tg.c
	src/json-tg.c
	src/python-tg.c
	src/python-types.c)
target_include_directories(${PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)
target_include_directories(${PROJECT_NAME} PUBLIC ${LUA_INCLUDE_DIR})
target_include_directories(${PROJECT_NAME} PUBLIC ${JANSSON_INCLUDE_DIR})
target_include_directories(${PROJECT_NAME} PUBLIC ${Readline_INCLUDE_DIR})
target_include_directories(${PROJECT_NAME} PUBLIC ${LIBCONFIG_INCLUDE_DIR})
target_compile_definitions(${PROJECT_NAME} PRIVATE USE_LUA)
target_link_libraries(${PROJECT_NAME} PUBLIC tgl OpenSSL::Crypto OpenSSL::SSL ZLIB::ZLIB ${LUA_LIBRARIES} ${JANSSON_LIBRARIES} ${Readline_LIBRARY} ${LIBCONFIG_LIBRARIES} ${CMAKE_DL_LIBS} ${CMAKE_THREAD_LIBS_INIT})
if (NOT WIN32)
target_link_libraries(${PROJECT_NAME} PUBLIC m)
endif()
# -lconfig -lutil
