# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.10

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/duan/GetPlateRectFromImage

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/duan/GetPlateRectFromImage/build

# Include any dependencies generated for this target.
include CMakeFiles/TEST_Detection.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/TEST_Detection.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/TEST_Detection.dir/flags.make

CMakeFiles/TEST_Detection.dir/PlateDetection.cpp.o: CMakeFiles/TEST_Detection.dir/flags.make
CMakeFiles/TEST_Detection.dir/PlateDetection.cpp.o: ../PlateDetection.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/duan/GetPlateRectFromImage/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/TEST_Detection.dir/PlateDetection.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/TEST_Detection.dir/PlateDetection.cpp.o -c /home/duan/GetPlateRectFromImage/PlateDetection.cpp

CMakeFiles/TEST_Detection.dir/PlateDetection.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/TEST_Detection.dir/PlateDetection.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/duan/GetPlateRectFromImage/PlateDetection.cpp > CMakeFiles/TEST_Detection.dir/PlateDetection.cpp.i

CMakeFiles/TEST_Detection.dir/PlateDetection.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/TEST_Detection.dir/PlateDetection.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/duan/GetPlateRectFromImage/PlateDetection.cpp -o CMakeFiles/TEST_Detection.dir/PlateDetection.cpp.s

CMakeFiles/TEST_Detection.dir/PlateDetection.cpp.o.requires:

.PHONY : CMakeFiles/TEST_Detection.dir/PlateDetection.cpp.o.requires

CMakeFiles/TEST_Detection.dir/PlateDetection.cpp.o.provides: CMakeFiles/TEST_Detection.dir/PlateDetection.cpp.o.requires
	$(MAKE) -f CMakeFiles/TEST_Detection.dir/build.make CMakeFiles/TEST_Detection.dir/PlateDetection.cpp.o.provides.build
.PHONY : CMakeFiles/TEST_Detection.dir/PlateDetection.cpp.o.provides

CMakeFiles/TEST_Detection.dir/PlateDetection.cpp.o.provides.build: CMakeFiles/TEST_Detection.dir/PlateDetection.cpp.o


CMakeFiles/TEST_Detection.dir/main.cpp.o: CMakeFiles/TEST_Detection.dir/flags.make
CMakeFiles/TEST_Detection.dir/main.cpp.o: ../main.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/duan/GetPlateRectFromImage/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/TEST_Detection.dir/main.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/TEST_Detection.dir/main.cpp.o -c /home/duan/GetPlateRectFromImage/main.cpp

CMakeFiles/TEST_Detection.dir/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/TEST_Detection.dir/main.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/duan/GetPlateRectFromImage/main.cpp > CMakeFiles/TEST_Detection.dir/main.cpp.i

CMakeFiles/TEST_Detection.dir/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/TEST_Detection.dir/main.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/duan/GetPlateRectFromImage/main.cpp -o CMakeFiles/TEST_Detection.dir/main.cpp.s

CMakeFiles/TEST_Detection.dir/main.cpp.o.requires:

.PHONY : CMakeFiles/TEST_Detection.dir/main.cpp.o.requires

CMakeFiles/TEST_Detection.dir/main.cpp.o.provides: CMakeFiles/TEST_Detection.dir/main.cpp.o.requires
	$(MAKE) -f CMakeFiles/TEST_Detection.dir/build.make CMakeFiles/TEST_Detection.dir/main.cpp.o.provides.build
.PHONY : CMakeFiles/TEST_Detection.dir/main.cpp.o.provides

CMakeFiles/TEST_Detection.dir/main.cpp.o.provides.build: CMakeFiles/TEST_Detection.dir/main.cpp.o


# Object files for target TEST_Detection
TEST_Detection_OBJECTS = \
"CMakeFiles/TEST_Detection.dir/PlateDetection.cpp.o" \
"CMakeFiles/TEST_Detection.dir/main.cpp.o"

# External object files for target TEST_Detection
TEST_Detection_EXTERNAL_OBJECTS =

../TEST_Detection: CMakeFiles/TEST_Detection.dir/PlateDetection.cpp.o
../TEST_Detection: CMakeFiles/TEST_Detection.dir/main.cpp.o
../TEST_Detection: CMakeFiles/TEST_Detection.dir/build.make
../TEST_Detection: /usr/local/lib/libopencv_dnn.so.3.4.0
../TEST_Detection: /usr/local/lib/libopencv_ml.so.3.4.0
../TEST_Detection: /usr/local/lib/libopencv_objdetect.so.3.4.0
../TEST_Detection: /usr/local/lib/libopencv_shape.so.3.4.0
../TEST_Detection: /usr/local/lib/libopencv_stitching.so.3.4.0
../TEST_Detection: /usr/local/lib/libopencv_superres.so.3.4.0
../TEST_Detection: /usr/local/lib/libopencv_videostab.so.3.4.0
../TEST_Detection: /usr/local/lib/libopencv_viz.so.3.4.0
../TEST_Detection: /usr/local/lib/libopencv_calib3d.so.3.4.0
../TEST_Detection: /usr/local/lib/libopencv_features2d.so.3.4.0
../TEST_Detection: /usr/local/lib/libopencv_flann.so.3.4.0
../TEST_Detection: /usr/local/lib/libopencv_highgui.so.3.4.0
../TEST_Detection: /usr/local/lib/libopencv_photo.so.3.4.0
../TEST_Detection: /usr/local/lib/libopencv_video.so.3.4.0
../TEST_Detection: /usr/local/lib/libopencv_videoio.so.3.4.0
../TEST_Detection: /usr/local/lib/libopencv_imgcodecs.so.3.4.0
../TEST_Detection: /usr/local/lib/libopencv_imgproc.so.3.4.0
../TEST_Detection: /usr/local/lib/libopencv_core.so.3.4.0
../TEST_Detection: CMakeFiles/TEST_Detection.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/duan/GetPlateRectFromImage/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking CXX executable ../TEST_Detection"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/TEST_Detection.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/TEST_Detection.dir/build: ../TEST_Detection

.PHONY : CMakeFiles/TEST_Detection.dir/build

CMakeFiles/TEST_Detection.dir/requires: CMakeFiles/TEST_Detection.dir/PlateDetection.cpp.o.requires
CMakeFiles/TEST_Detection.dir/requires: CMakeFiles/TEST_Detection.dir/main.cpp.o.requires

.PHONY : CMakeFiles/TEST_Detection.dir/requires

CMakeFiles/TEST_Detection.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/TEST_Detection.dir/cmake_clean.cmake
.PHONY : CMakeFiles/TEST_Detection.dir/clean

CMakeFiles/TEST_Detection.dir/depend:
	cd /home/duan/GetPlateRectFromImage/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/duan/GetPlateRectFromImage /home/duan/GetPlateRectFromImage /home/duan/GetPlateRectFromImage/build /home/duan/GetPlateRectFromImage/build /home/duan/GetPlateRectFromImage/build/CMakeFiles/TEST_Detection.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/TEST_Detection.dir/depend
