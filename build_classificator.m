clc; clear;

load("data/training/hog_features");

[n_plates, ~] = size(all_plates_hf);
[n_other, ~] = size(all_no_plates_hf); 
all_training_data = [all_plates_hf; all_no_plates_hf];
labels = [
    repmat("plate", n_plates, 1);
    repmat("other", n_other, 1)
    ];

model = fitcknn(all_training_data, labels);
   
% Test the model using data that was not present not present in the
% training set.

test_dir = "data/test_classificator/";
should_be_plate = ["P6070066_plate.jpg", "P6070075_plate.jpg"];
should_not_be_plate = [
    "P6070066_non_plate_1.jpg" ...
    "P6070066_non_plate_2.jpg" ...
    "P6070066_non_plate_3.jpg" ...
    "P6070075_non_plate_1.jpg" ...
    "P6070075_non_plate_2.jpg" ...
    "P6070075_non_plate_3.jpg" ...
    ];
all_test_filenames = [should_be_plate, should_not_be_plate];
complete_test_dataset = [];
expected_test_results = [];


% Test images that are license plates
for i=1:length(should_be_plate)
    filepath = fullfile(test_dir, should_be_plate(i));
    img = imread(filepath);
    hf = extractHOGFeatures(img);
    complete_test_dataset = [complete_test_dataset; hf];
    expected_test_results = [expected_test_results; "plate"];
end
save("data/classificator", "model")

% Test images that are not license plates
for i=1:length(should_not_be_plate)
    filepath = fullfile(test_dir, should_not_be_plate(i));
    img = imread(filepath);
    hf = extractHOGFeatures(img);
    complete_test_dataset = [complete_test_dataset; hf];
    expected_test_results = [expected_test_results; "other"];
end

test_results = model.predict(complete_test_dataset);
for i=1:length(test_results)
    if test_results{i} == expected_test_results(i)
        disp("Test passed: " + all_test_filenames(i))
    else
        disp("Test: failed" + all_test_filenames(i))
    end
end