function ConvertLS_dataToMAT ()

    all_symptoms_ls = {}; % 16 symptoms to predict lumpy skin, important for GUI
    all_symptoms_ls_index = 0;

    symptoms_ls = []; % symptoms of all document cases of lumpy skin
    symptoms_ls_index = 0; 

    target_ls = []; % targets to know if patient has lumpy skin (1) or not (0)


    current_file = fopen("TEST Lumpy skin disease data.csv");

    line = fgetl(current_file); % skip header

    current_data = strsplit(line,';');

    % for-loop to get the header of csv and store the needed symptoms in a
    % cell array
    for i=1:(size(current_data,2)-1)
            if ~isempty(deblank(current_data{1,i}))
                all_symptoms_ls_index=all_symptoms_ls_index + 1; 
                all_symptoms_ls{all_symptoms_ls_index,1}=deblank(current_data{1,i}); 
            end
    end
    
    fclose(current_file);

    current_file = fopen("TEST Lumpy skin disease data.csv"); % open file again

    line = fgetl(current_file); % get first line


    % while-loop to store symptoms in an array
    while ~feof(current_file)

        line=fgetl(current_file); % get current line in the file
        current_data=strsplit(line,';'); % split data

        symptoms_ls_index=symptoms_ls_index + 1; % increase index
        new_data=str2double(current_data); % convert strings to doubles

        for i=1:(size(current_data, 2) - 1) % last column are the targets, don't need them in the array
            symptoms_ls(symptoms_ls_index, i)=new_data(1,i);
        end
        % store last column in target array, is needed for training the ML model
        target_ls(symptoms_ls_index, 1) = new_data(1, size(current_data,2));

    end
   
    fclose(current_file); 

    save('converted Lumpy skin disease data.mat', 'symptoms_ls', 'all_symptoms_ls', 'target_ls');

end