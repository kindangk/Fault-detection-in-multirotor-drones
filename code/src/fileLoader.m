function functions = fileLoader()
    functions.loadSafe = @loadSafe;
    functions.loadOnly = @loadOnly;
end

%{
    The simple usage of "load" throws exceptions because of invalid
    field names. For this reason, "loadSafe" iterates over the data
    fields contained in each file and only loads those with valid
    names. The invalid fields are not relevant for the purpose of this
    project.
%}

% Load each field separately and check the validity of its name
function loadedData = loadSafe(filePath, fileName)
   % Get the list of fields of the file
    fields = whos('-file', filePath);

    % Initialize empty data structure
    loadedData = struct();

    counter = 0;

    % Iterate over the fields of the file
    for k = 1:numel(fields)
        name = fields(k).name;
        try
            % Load single field
            tmp = load(filePath, name);

            % Save field data into "loadedData"
            loadedData.(matlab.lang.makeValidName(name)) = tmp.(name);
        catch ME
            %warning('Skipping variable %s: %s', name, ME.message);
            counter = counter + 1;
        end
    end

    if (counter > 0)
        warning('Skipped %d fields for file %s', counter, fileName);
    end
end

% Load each field separately and check the validity of its name
function loadedData = loadOnly(filePath, fileName, fieldList)
    % Initialize empty data structure
    loadedData = struct();

    counter = 0;

    % Iterate over the fields in "fieldList"
    for k = 1:numel(fieldList)
        name = fieldList(k);
        try
            % Load single field
            tmp = load(filePath, name);

            % Save field data into "loadedData"
            loadedData.(matlab.lang.makeValidName(name)) = tmp.(name);
        catch ME
            %warning('Skipping variable %s: %s', name, ME.message);
            counter = counter + 1;
        end
    end

    if (counter > 0)
        warning('Skipped %d fields for file %s', counter, fileName);
    end
end


