function mydtree(training_file, test_file, option, pruning_thru)

training_data  = importdata(training_file);
test_data = importdata(test_file);
threshold = pruning_thru;
type = option;

data_dimension = size(training_data,2);
classes = zeros(size(training_data,1),1);% initializing classes vector to 0
classes(:,1) = training_data(:,data_dimension); %defining classes vector
unique_classes = unique(classes);% displays different classes in ascending order
num_classes = numel(unique_classes); % displays the number of classes

num_columns = size(training_data,2); %number of columns of training_data
    
default = distribution(training_data, num_classes, unique_classes);
    
    if (strcmp(type,'forest3'))
        for i=1:3
            tree3(i,1) = dtl(training_data, num_columns, default, threshold, type, num_classes,unique_classes);
            print_funct(tree3(i,1),i);
        end
    elseif (strcmp(type,'forest15'))
        for i=1:15
            tree15(i,1) = dtl(training_data, num_columns, default, threshold, type, num_classes, unique_classes);
            print_funct(tree15(i,1),i);
        end
    else
        tree = dtl(training_data, num_columns, default, threshold, type, num_classes, unique_classes);
        print_funct(tree,1);
    end
    
dimension_test = size(test_data,2);
classes_test = zeros(size(test_data,1),1);% initializing classes vector to 0
classes_test(:,1) = test_data(:,dimension_test); %defining classes vector
accuracy = zeros(size(test_data,1),1);
num_rows = size(test_data,1);
distribution_val = zeros(size(num_classes));
predicted = str2double(-1);
predicted_val = str2double(-1);

    if(strcmp(type,'forest3'))
        for i = 1:num_rows
        for k=1:3
           temp = tree3(k,1);
            while(isstruct(temp))
                if(test_data(i,temp.best_attribute) < temp.best_threshold)
                    temp = temp.left_child;
                else
                    temp = temp.right_child;
                end
            end
            distribution_val = temp + distribution_val;
        end      
        
        distribution_val= distribution_val/3;
        
        [predicted,predicted_val] = max(distribution_val);
       if(unique_classes(1,1)==0)
        if(classes_test(i,1) == predicted_val-1)
            accuracy(i,1) = 1;
        else
            accuracy(i,1) = 0;
        end
       else
           if(classes_test(i,1) == predicted_val)
            accuracy(i,1) = 1;
        else
            accuracy(i,1) = 0;
           end
       end
       fprintf('ID=%5d, predicted=%3d, true=%3d, accuracy=%4.2f\n', i-1, predicted_val, classes(i,1), accuracy(i,1));
        end
    elseif(strcmp(type, 'forest15'))
        for i = 1:num_rows
           for k=1:15
           temp = tree15(k,1);
            while(isstruct(temp))
                if(test_data(i,temp.best_attribute) < temp.best_threshold)
                    temp = temp.left_child;
                else
                    temp = temp.right_child;
                end
            end
            distribution_val = temp + distribution_val;
           end      
        
        distribution_val= distribution_val/15;

        [predicted,predicted_val] = max(distribution_val);
       if(unique_classes(1,1)==0)
        if(classes_test(i,1) == predicted_val-1)
            accuracy(i,1) = 1;
        else
            accuracy(i,1) = 0;
        end
       else
           if(classes_test(i,1) == predicted_val)
            accuracy(i,1) = 1;
        else
            accuracy(i,1) = 0;
           end
       end
       fprintf('ID=%5d, predicted=%3d, true=%3d, accuracy=%4.2f\n', i-1, predicted_val, classes(i,1), accuracy(i,1));
        end
       
    else
        
       for i = 1:num_rows
           temp = tree;
        while(isstruct(temp))
            if(test_data(i,temp.best_attribute) < temp.best_threshold)
                temp = temp.left_child;
            else
                temp = temp.right_child;
            end
        end

        [predicted,predicted_val] = max(temp);
       if(unique_classes(1,1)==0)
        if(classes_test(i,1) == predicted_val-1)
            accuracy(i,1) = 1;
        else
            accuracy(i,1) = 0;
        end
       else
           if(classes_test(i,1) == predicted_val)
            accuracy(i,1) = 1;
        else
            accuracy(i,1) = 0;
           end
       end
       fprintf('ID=%5d, predicted=%3d, true=%3d, accuracy=%4.2f\n', i-1, predicted_val, classes(i,1), accuracy(i,1));
       end
    end
    fprintf('classification accuracy=%6.4f\n', mean(accuracy));
end

