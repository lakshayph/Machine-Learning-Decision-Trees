function [gain] = information_gain(data, col, threshold)

data_dimension = size(data,2);% number of columns in data matrix
classes = zeros(size(data,1),1);% initializing classes vector to 0
classes(:,1) = data(:,data_dimension); %defining classes vector
unique_classes = unique(classes);% displays different classes in ascending order
num_classes = numel(unique_classes); % displays the number of classes
class_val = zeros(num_classes,1);% to store the count of number of elements belonging to different classes
class_val_right_val = zeros(num_classes,1);
class_val_left_val = zeros(num_classes,1);
entropy = 0;
entropy_right = 0;
entropy_left = 0;

    for k = 1:num_classes
        for i = 1:size(classes,1)
            if (classes(i,1) == unique_classes(k,1))
                class_val(k,1) = class_val(k,1) + 1;
            end
        end
    end
    
    for k = 1:num_classes
        entropy = entropy - ((class_val(k,1)/size(classes,1)) * (log2(class_val(k,1)/size(classes,1))));
    end
    
    right_col = [];
    left_col = [];
    class_right_col = [];
    class_left_col = [];
    
    for i=1:size(data,1)
        if (data(i,col) >= threshold)
            right_col = [right_col;data(i,1)];
            class_right_col = [class_right_col; data(i,data_dimension)];
        else
            left_col = [left_col; data(i,1)];
            class_left_col = [class_left_col; data(i,data_dimension)];
        end
    end
    
    for k = 1:num_classes
        for i = 1:size(class_right_col,1)
            if (class_right_col(i,1) == unique_classes(k,1))
                class_val_right_val(k,1) = class_val_right_val(k,1) + 1;
            end
        end
    end
    
    for k = 1:num_classes
        e1r = class_val_right_val(k,1);
        e2r = size(class_right_col,1);
        if (e1r == 0)
            entropy_right = entropy_right - 0;
        else
            e3r = log2(e1r/e2r);
            entropy_right = entropy_right - ((e1r/e2r) * (e3r));
        end
    end
    
    for k = 1:num_classes
        for i = 1:size(class_left_col,1)
            if (class_left_col(i,1) == unique_classes(k,1))
                class_val_left_val(k,1) = class_val_left_val(k,1) + 1;
            end
        end
    end
    
    for k = 1:num_classes
        e1 = class_val_left_val(k,1);
        e2 = size(class_left_col,1);
        if (e1 == 0)
            entropy_left = entropy_left - 0;
        else
            e3 = log2(e1/e2);
            entropy_left = entropy_left - ((e1/e2) * (e3));
        end
    end
    
    gain = entropy - ((size(class_left_col,1)/size(classes,1))*entropy_left) - ((size(class_right_col,1)/size(classes,1))*entropy_right);
end

