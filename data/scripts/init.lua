function Load()
    LoadLibrary(SOL_LIBRARY_PACKAGE);
    LoadLibrary(SOL_LIBRARY_OS);
    LoadLibrary(SOL_LIBRARY_IO);
    LoadLibrary(SOL_LIBRARY_BASE);
    LoadLibrary(SOL_LIBRARY_STRING);
    LoadLibrary(SOL_LIBRARY_MATH);
    LoadLibrary(SOL_LIBRARY_TABLE);
    LoadLibrary(SOL_LIBRARY_DEBUG);
    LoadLibrary(SOL_LIBRARY_COROUTINE);

    LoadScriptFile("scripts/envari/mathextension.lua")
    LoadScriptFile("scripts/codegen/FileMap.lua")
    LoadScriptFile("scripts/codegen/ShaderMap.lua")
    LoadScriptFile("scripts/codegen/FolderMap.lua")

    drawShaderID = CompileProgram(SHADERS_CORE_TEXTURED_VERT, SHADERS_TEST_TEST_FRAG)
end

function Update()
    DrawDefaultTransform();

    DrawClear(0, 0, 0, 1);
    
    -- colorB = math.clamp(
    --     math.sin(i * colorOffset + time.gameTime + perLineOffset * j) +
    --     math.cos(i * colorOffset + time.gameTime + perLineOffset * j),
    --     0.35, 1);

    -- DrawOverrideProgram(drawShaderID)
    -- DrawSetTransform(0, 0, 2, 2, 0);
    CirclesV1();
    -- CirclesV2();

    -- DrawDisableOverrideProgram()
    -- DrawString(0, 0, "Render test 2000\nASD");
end

function CirclesV1()
    radius = 20;
    colorOffset = 0.1;
    ySpeed = 3;
    yOffset = 8;
    perLineOffset = 0.55;
    distance = V2(25, 30);
    count = V2(math.floor(render.bufferSize.x / distance.x), math.floor(render.bufferSize.y / distance.y));

    t = time.gameTime;
    st = math.sin(t);
    sst = st * 0.5 + 0.5;
    ast = math.abs(math.sin(t));
    mt = math.fmod(t, 1);

    for j=0,count.y do
        for i=0,count.x do
            ni = i / count.x;

            colorB = math.sin(i * 0.2 + t * 0.5 + j * perLineOffset) * 0.5 + 0.5;

            DrawColor(0, colorB, 1, 1);
            DrawCircle(0 + i * distance.x, j * distance.y + math.sin(i + time.gameTime * ySpeed) * yOffset, radius, 0);
        end
    end
end

function CirclesV2()
    DrawImage(0, 0, IMAGES_PATTERNS_PATTERN06_PNG, 0);
    radius = 50;
    colorOffset = 0.1;
    ySpeed = 5;
    yOffset = 5;
    perLineOffset = 0.5;
    distance = V2(25, 25);
    count = V2(math.ceil(render.bufferSize.x / distance.x), math.ceil(render.bufferSize.y / distance.y));

    t = time.gameTime;
    st = math.sin(t);
    sst = st * 0.5 + 0.5;
    ast = math.abs(math.sin(t));
    mt = math.fmod(t, 1);

    for j=0,count.y do
        for i=0,count.x do
            ni = i / count.x;

            colorB = math.sin(i * 0.2 + t * 0.5 + j * perLineOffset) * 0.5 + 0.5;

            -- DrawColor(0, colorB, 1, 1);
            DrawColor(0, Perlin2DOctaves(i + t, j + t, 8, 0.023), 1, 1);
            DrawCircle(0 + i * distance.x, j * distance.y + math.sin(i + time.gameTime * ySpeed) * yOffset, radius, 0);
        end
    end
end

function Unload()

end

function End()
    
end