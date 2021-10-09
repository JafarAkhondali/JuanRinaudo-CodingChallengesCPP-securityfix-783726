function Load()
    LoadLibrary(SOL_LIBRARY_PACKAGE);
    LoadLibrary(SOL_LIBRARY_OS);
    LoadLibrary(SOL_LIBRARY_IO);
    LoadLibrary(SOL_LIBRARY_BASE);
    LoadLibrary(SOL_LIBRARY_STRING);
    LoadLibrary(SOL_LIBRARY_MATH);
    LoadLibrary(SOL_LIBRARY_TABLE);
    LoadLibrary(SOL_LIBRARY_COROUTINE);

    LoadScriptFile("scripts/codegen/ShaderMap.lua")
    LoadScriptFile("scripts/codegen/FileMap.lua")
    LoadScriptFile("scripts/envari/mathextension.lua")

    artsyProgram = CompileProgramPlatform(COLOREDINSTANCEDARTSY_VERT, COLOREDINSTANCEDARTSY_FRAG);
    artsyLocationCountXY = GetUniformLocation(artsyProgram, "countXY")
end

function Update()
    DrawSetLayer(0, false);
    DrawDefaultTransform();

    DrawClear(0, 0, 0, 1);
    DrawColor(1, 0, 0, 1);

    divisor = 1;
    radius = 30;
    colorOffset = 0.1;
    ySpeed = 3;
    yOffset = 8;
    perLineOffset = 0.55;
    distance = V2(20 / divisor, 25 / divisor);
    
    count = V2(math.floor(render.bufferSize.x / distance.x), math.floor(render.bufferSize.y / distance.y));

    t = time.gameTime;
    st = math.sin(t);
    sst = st * 0.5 + 0.5;
    ast = math.abs(math.sin(t));
    mt = math.fmod(t, 1);

    instancePositions = {};

    pi = 1;
    for j=0,(count.y + 1) do
        for i=0,(count.x + 1) do
            instancePositions[pi + 0] = i * distance.x;
            instancePositions[pi + 1] = j * distance.y;-- + math.sin(i + time.gameTime * ySpeed) * yOffset;
            pi = pi + 2
        end
    end

    instanceCount = (count.x + 2) * (count.y + 2);

    SetUniform2F(artsyProgram, artsyLocationCountXY, count.x + 2, count.y + 2);

    DrawOverrideProgram(artsyProgram);
    DrawInstancedCircles(instanceCount, instancePositions, radius, 8);
    DrawDisableOverrideProgram();
    --DrawInstancedCircles(batchPositions, radius, 8);
end

function Unload()

end

function End()
    
end