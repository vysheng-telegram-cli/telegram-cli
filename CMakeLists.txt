cmake_minimum_required(VERSION 3.18 FATAL_ERROR)

project(telegram-cli LANGUAGES C)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

find_package(OpenSSL REQUIRED COMPONENTS Crypto SSL)
find_package(ZLIB REQUIRED)
find_package(Threads REQUIRED)
find_package(Readline REQUIRED)
find_package(LibConfig REQUIRED)

add_subdirectory(ThirdParty/tgl)

add_executable(${PROJECT_NAME}
	src/main.c
	src/loop.c
	src/interface.c)
target_include_directories(${PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)
target_include_directories(${PROJECT_NAME} PUBLIC ${Readline_INCLUDE_DIR})
target_include_directories(${PROJECT_NAME} PUBLIC ${LIBCONFIG_INCLUDE_DIR})
target_link_libraries(${PROJECT_NAME} PUBLIC tgl OpenSSL::Crypto OpenSSL::SSL ZLIB::ZLIB ${Readline_LIBRARY} ${LIBCONFIG_LIBRARIES} ${CMAKE_DL_LIBS} ${CMAKE_THREAD_LIBS_INIT})
if (NOT WIN32)
target_link_libraries(${PROJECT_NAME} PUBLIC m)
endif()
# -lconfig -lutil
