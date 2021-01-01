function Init()
    LoadLibrary(SOL_LIBRARY_PACKAGE);
    LoadLibrary(SOL_LIBRARY_OS);
    LoadLibrary(SOL_LIBRARY_IO);
    LoadLibrary(SOL_LIBRARY_BASE);
    LoadLibrary(SOL_LIBRARY_STRING);
    LoadLibrary(SOL_LIBRARY_MATH);
    LoadLibrary(SOL_LIBRARY_TABLE);
    LoadLibrary(SOL_LIBRARY_DEBUG);
    LoadLibrary(SOL_LIBRARY_COROUTINE);

    require("codegen.FileMap")
    require("codegen.FolderMap")
    
    if(screen.bufferSize.x > 0) then
        camera.size = screen.bufferSize.y;
        camera.ratio = screen.bufferSize.x / screen.bufferSize.y;
    else
        camera.size = screen.size.y;
        camera.ratio = screen.size.x / screen.size.y;
    end
    camera.nearPlane = 0.01;
    camera.farPlane = 100.0;
    camera.view = IdM44();
    camera.projection = OrtographicProjection(camera.size, camera.ratio, camera.nearPlane, camera.farPlane);
end

function Update()
    DrawClear(1, 0, 0, 1);

    -- DrawColor(1, 1, 1, 1);
    -- DrawImage(0, 0, 2, 2, IMAGES_PATTERNS_PATTERN06_PNG);

    DrawSetFont(defaultFontID);
    DrawString(0, 0, "Render test 2000\nASD");
end

function Unload()

end

function End()
    
end