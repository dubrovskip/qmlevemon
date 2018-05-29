find_package(Qt5Core REQUIRED)

function(ecm_androiddeployqt QTANDROID_EXPORTED_TARGET ECM_ADDITIONAL_FIND_ROOT_PATH ANDROID_APK_DIR)
    get_filename_component(_qt5Core_install_prefix "${Qt5Core_DIR}/../../../" ABSOLUTE)
    if(NOT ANDROID_APK_DIR)
        set(ANDROID_APK_DIR "${_qt5Core_install_prefix}/src/android/templates/")
    endif()

    set(EXPORT_DIR "${CMAKE_BINARY_DIR}/${QTANDROID_EXPORTED_TARGET}_build_apk/")
    set(EXECUTABLE_DESTINATION_PATH "${EXPORT_DIR}/libs/${CMAKE_ANDROID_ARCH_ABI}/lib${QTANDROID_EXPORTED_TARGET}.so")
    set(QML_IMPORT_PATHS "")
    foreach(prefix ${ECM_ADDITIONAL_FIND_ROOT_PATH})
        # qmlimportscanner chokes on symlinks, so we need to resolve those first
        get_filename_component(qml_path "${prefix}/lib/qml" REALPATH)
        if(EXISTS ${qml_path})
            if (QML_IMPORT_PATHS)
                set(QML_IMPORT_PATHS "${QML_IMPORT_PATHS},${qml_path}")
            else()
                set(QML_IMPORT_PATHS "${qml_path}")
            endif()
        endif()
    endforeach()
    if (QML_IMPORT_PATHS)
        set(DEFINE_QML_IMPORT_PATHS "\"qml-import-paths\": \"${QML_IMPORT_PATHS}\",")
    endif()

    set(EXTRA_PREFIX_DIRS "")
    foreach(prefix ${ECM_ADDITIONAL_FIND_ROOT_PATH})
        if (EXTRA_PREFIX_DIRS)
            set(EXTRA_PREFIX_DIRS "${EXTRA_PREFIX_DIRS}, \"${prefix}\"")
        else()
            set(EXTRA_PREFIX_DIRS "\"${prefix}\"")
        endif()
    endforeach()
    string(TOLOWER "${CMAKE_HOST_SYSTEM_NAME}" _LOWER_CMAKE_HOST_SYSTEM_NAME)
    configure_file("${_CMAKE_ANDROID_DIR}/deployment-file.json.in" "${QTANDROID_EXPORTED_TARGET}-deployment.json.in")

    if (CMAKE_GENERATOR STREQUAL "Unix Makefiles")
        set(arguments "\\$(ARGS)")
    endif()

    function(havestl var access VALUE)
        if (NOT VALUE STREQUAL "")
            file(WRITE ${CMAKE_BINARY_DIR}/stl "${VALUE}")
        endif()
    endfunction()
    variable_watch(CMAKE_CXX_STANDARD_LIBRARIES havestl)

    if (NOT TARGET create-apk)
        add_custom_target(create-apk)
    endif()

    set(CREATEAPK_TARGET_NAME "create-apk-${QTANDROID_EXPORTED_TARGET}")
    add_custom_target(${CREATEAPK_TARGET_NAME}
        COMMAND cmake -E echo "Generating $<TARGET_NAME:${QTANDROID_EXPORTED_TARGET}> with $<TARGET_FILE_DIR:Qt5::qmake>/androiddeployqt"
        COMMAND cmake -E remove_directory "${EXPORT_DIR}"
        COMMAND cmake -E copy_directory "${ANDROID_APK_DIR}" "${EXPORT_DIR}"
        COMMAND cmake -E copy "$<TARGET_FILE:${QTANDROID_EXPORTED_TARGET}>" "${EXECUTABLE_DESTINATION_PATH}"
        COMMAND LANG=C cmake "-DTARGET=$<TARGET_FILE:${QTANDROID_EXPORTED_TARGET}>" -P ${_CMAKE_ANDROID_DIR}/hasMainSymbol.cmake
        COMMAND LANG=C cmake -DINPUT_FILE="${QTANDROID_EXPORTED_TARGET}-deployment.json.in" -DOUTPUT_FILE="${QTANDROID_EXPORTED_TARGET}-deployment.json" "-DTARGET=$<TARGET_FILE:${QTANDROID_EXPORTED_TARGET}>" "-DOUTPUT_DIR=$<TARGET_FILE_DIR:${QTANDROID_EXPORTED_TARGET}>" "-DEXPORT_DIR=${CMAKE_INSTALL_PREFIX}" "-DECM_ADDITIONAL_FIND_ROOT_PATH=\"${ECM_ADDITIONAL_FIND_ROOT_PATH}\"" "-DANDROID_EXTRA_LIBS=\"${ANDROID_EXTRA_LIBS}\"" -P ${_CMAKE_ANDROID_DIR}/specifydependencies.cmake
        COMMAND $<TARGET_FILE_DIR:Qt5::qmake>/androiddeployqt --gradle --input "${QTANDROID_EXPORTED_TARGET}-deployment.json" --output "${EXPORT_DIR}" --deployment bundled ${arguments}
    )

    add_custom_target(install-apk-${QTANDROID_EXPORTED_TARGET}
        COMMAND adb install -r "${EXPORT_DIR}/build/outputs/apk/${QTANDROID_EXPORTED_TARGET}_build_apk-debug.apk"
    )
    add_dependencies(create-apk ${CREATEAPK_TARGET_NAME})
endfunction()
