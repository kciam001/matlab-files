clc;clear;

bins = [5, 10, 50, 100];

%-------------Load Iris Data-----------------
FID = fopen('iris.data');
C_data0 = textscan(FID,'%f%f%f%f%s', 200, 'Delimiter',',');
irisMatrix = cell2mat(C_data0(:,1:4)); %ignores the last column of strings
fclose(FID);
%-------------Load Wine Data-----------------
FID = fopen('wine.data');
C_data0 = textscan(FID,'%f%f%f%f%f%f%f%f%f%f%f%f%f%f','Delimiter',',');
wineMatrix = cell2mat(C_data0(:,2:14));
fclose(FID);
%-------------Generate Histograms------------
%GenerateIrisHistograms(bins, irisMatrix)
%GenerateWineHistograms(bins, wineMatrix)
%-------------Generate Box-Plots-------------
%GenerateIrisBoxplots(irisMatrix)
%GenerateWineBoxPlots(wineMatrix)
%--------------------------------------------




function GenerateIrisBoxplots(irisMatrix)
    setosaMatrix = irisMatrix(1:50,:);
    versiColorMatrix = irisMatrix(51:100,:);
    verginicaMatrix = irisMatrix(101:150,:);
    
    irisNames = ["setosa", "versicolor", "verginica"];
    
    for (iris = 1: 1: 3)
        for(attribute = 1: 1: 4)
            fileName = 'boxplot_';
            currName = irisNames(iris);
            if(currName == "setosa")
                fileName = strcat(fileName, currName);
                fileName = strcat(fileName, '_attribute_(');
                fileName = strcat(fileName, num2str(attribute));
                fileName = strcat(fileName, ').png');

                boxplot(setosaMatrix(:,attribute));
                saveas(gcf, fileName);
                
            elseif(currName == "versicolor")
                fileName = strcat(fileName, currName);
                fileName = strcat(fileName, '_attribute_(');
                fileName = strcat(fileName, num2str(attribute));
                fileName = strcat(fileName, ').png');

                boxplot(versiColorMatrix(:,attribute));
                saveas(gcf, fileName);
            elseif(currName == "verginica")
                fileName = strcat(fileName, currName);
                fileName = strcat(fileName, '_attribute_(');
                fileName = strcat(fileName, num2str(attribute));
                fileName = strcat(fileName, ').png');

                boxplot(verginicaMatrix(:,attribute));
                saveas(gcf, fileName);
            end
            
        end
    end


end
function GenerateWineBoxPlots(wineMatrix)
    wineOneMatrix = wineMatrix(1:59,1:3);
    wineTwoMatrix = wineMatrix(60:130,1:3);
    wineThreeMatrix = wineMatrix(131:178,1:3);
    
    wineNames = ["wineone", "winetwo", "winethree"];
    
    for (wine = 1: 1: 3)
        for(attribute = 1: 1: 3)
            fileName = 'boxplot_';
            currName = wineNames(wine);
            if(currName == "wineone")
                fileName = strcat(fileName, currName);
                fileName = strcat(fileName, '_attribute_(');
                fileName = strcat(fileName, num2str(attribute));
                fileName = strcat(fileName, ').png');

                boxplot(wineOneMatrix(:,attribute));
                saveas(gcf, fileName);
                
            elseif(currName == "winetwo")
                fileName = strcat(fileName, currName);
                fileName = strcat(fileName, '_attribute_(');
                fileName = strcat(fileName, num2str(attribute));
                fileName = strcat(fileName, ').png');

                boxplot(wineTwoMatrix(:,attribute));
                saveas(gcf, fileName);
            elseif(currName == "winethree")
                fileName = strcat(fileName, currName);
                fileName = strcat(fileName, '_attribute_(');
                fileName = strcat(fileName, num2str(attribute));
                fileName = strcat(fileName, ').png');

                boxplot(wineThreeMatrix(:,attribute));
                saveas(gcf, fileName);
            end
            
        end
    end
end
function GenerateIrisHistograms(bins, irisMatrix)
    setosaMatrix = irisMatrix(1:50,:);
    versiColorMatrix = irisMatrix(51:100,:);
    verginicaMatrix = irisMatrix(101:150,:);


    irisNames = ["setosa", "versicolor", "verginica"];

    for (iris = 1: 1: 3)
        for(attribute = 1: 1: 4)
            for (bin = 1: 1: 4)
                currName = irisNames(iris);
                if (currName == "setosa")
                    BarGraphHelper(bins(bin), setosaMatrix, attribute, irisNames(iris));
                elseif(currName == "versicolor")
                    BarGraphHelper(bins(bin), versiColorMatrix, attribute, irisNames(iris));
                elseif(currName == "verginica")
                    BarGraphHelper(bins(bin), verginicaMatrix, attribute, irisNames(iris));
                end

            end
        end
    end
end

function GenerateWineHistograms(bins, wineMatrix)
    wineOneMatrix = wineMatrix(1:59,1:3);
    wineTwoMatrix = wineMatrix(60:130,1:3);
    wineThreeMatrix = wineMatrix(131:178,1:3);

    wineNames = ["wineone", "winetwo", "winethree"];

    for (wine = 1: 1: 3)
        for(attribute = 1: 1: 3)
            for (bin = 1: 1: 4)
                currName = wineNames(wine);
                if (currName == "wineone")
                    BarGraphHelper(bins(bin), wineOneMatrix, attribute, wineNames(wine));
                elseif(currName == "winetwo")
                    BarGraphHelper(bins(bin), wineTwoMatrix, attribute, wineNames(wine));
                elseif(currName == "winethree")
                    BarGraphHelper(bins(bin), wineThreeMatrix, attribute, wineNames(wine));
                end

            end
        end
    end
end

function BarGraphHelper(bins, dataset, attribute, name)
    bin = bins;
    first = dataset(:,attribute);
    min_first = min(first);
    max_first = max(first);
    range = (max_first - min_first)/bin;
    %range = 0.1
    Y = zeros(1,bin);
    r1 = min_first;
    r2 = min_first + range;
    X = cell(1,bin);
    for i=1:bin
        X{i} = sprintf('%.2f-%.2f', r1, r2);
        Y(i) = size(first(first>r1 & first<=r2),1);
        r1 = r2;
        r2 = r2 + range;
    end
    X = categorical(X);
    class = name;
    fileName = strcat(class, '_attribute(');
    fileName = strcat(fileName, num2str(attribute));
    fileName = strcat(fileName,')_bins(');
    fileName = strcat(fileName, num2str(bins));
    fileName = strcat(fileName, ')');
    fileName = strcat(fileName, '.png');
    bar(X,Y);
    saveas(gcf,fileName);

end




