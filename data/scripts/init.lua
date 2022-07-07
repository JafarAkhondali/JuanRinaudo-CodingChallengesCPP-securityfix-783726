function Load()
    LoadLibrary(SOL_LIBRARY_BASE);
    LoadLibrary(SOL_LIBRARY_STRING);
    LoadLibrary(SOL_LIBRARY_MATH);
    LoadLibrary(SOL_LIBRARY_TABLE);

    LoadScriptFile("scripts/codegen/FileMap.lua")
    LoadScriptFile(SCRIPTS_CODEGEN_SHADERMAP_LUA)
    LoadScriptFile(SCRIPTS_ENVARI_ENVARIEXTENSIONS_LUA)

    artsyProgram = CompileProgramPlatform(COLOREDINSTANCEDARTSY_VERT, COLOREDINSTANCEDARTSY_FRAG);
    artsyLocationCountXY = GetUniformLocation(artsyProgram, "countXY")

    divisor = 1;
    circleRadius = 30;
    distance = V2(20 / divisor, 25 / divisor);
    
    count = V2(math.floor(render.bufferSize.x / distance.x), math.floor(render.bufferSize.y / distance.y));

    instancePositions = {};

    positioIndex = 1;
    for j=0,(count.y + 1) do
        for i=0,(count.x + 1) do
            instancePositions[positioIndex + 0] = i * distance.x;
            instancePositions[positioIndex + 1] = j * distance.y;-- + math.sin(i + time.gameTime * ySpeed) * yOffset;
            positioIndex = positioIndex + 2
        end
    end

    editorShaderDebugger.programIndex = 5;
    editorShaderDebugger.programIndexChanged = true;
end

function Update()
    DrawSetLayer(0, false);
    DrawDefaultTransform();

    DrawClear(0, 0, 0, 1);
    DrawColor(1, 0, 0, 1);

    instanceCount = (count.x + 2) * (count.y + 2);

    SetUniform2F(artsyProgram, artsyLocationCountXY, count.x + 2, count.y + 2);

    DrawOverrideProgram(artsyProgram);
    DrawInstancedCircles(instanceCount, instancePositions, circleRadius, 8);
    DrawDisableOverrideProgram();
end

function EditorShaderReload()
    artsyLocationCountXY = GetUniformLocation(artsyProgram, "countXY")
end

function Unload()

end

function End()
    
end