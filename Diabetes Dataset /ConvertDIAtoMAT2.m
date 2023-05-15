function ConvertDIAtoMAT2 ()

    inputs = zeros(2768, 8); % allocate the table with the diabetes parameters 
    inputs_index = 0;

    outputs = zeros(2768, 1); % allocate the column with the variable "Outcome" for prediction


    curr_file = fopen("DiabetesDataset.csv"); % open file

    fgetl(curr_file); % remove header 

    while ~feof(curr_file)

        curr_line=fgetl(curr_file); %get current line in the file

        curr_dat=strsplit(curr_line,','); %split the read line on all ','

        inputs_index = inputs_index + 1; % for each line increase the line in table
        new_dat = str2double(curr_dat); %convert current data to double

        lastEntry = size(curr_dat,2);

        for i = 1:(lastEntry - 1) % insert data from csv file line per line for the input parameters
            inputs(inputs_index,i) = new_dat(1,i); 

        end

        outputs(inputs_index, 1) = new_dat(1, lastEntry); % insert the Outcome parameter as predictor (output)
    end

    fclose(curr_file); %close the file

    save('DiabetesDataset.mat','inputs', 'outputs'); % save the tables for inputs and outputs

end