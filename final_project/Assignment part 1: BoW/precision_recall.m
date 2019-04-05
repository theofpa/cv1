function [p,r,a] = precision_recall(ytest, labels)
    truepositive = sum(labels == ytest & labels == 1);
    falsepositive = sum(labels ~= ytest & labels == 1);
    truenegative = sum(labels == ytest & labels == 0);
    falsenegative = sum(labels ~= ytest & labels == 0);
    p = truepositive / (truepositive + falsepositive);
    r = truepositive / (truepositive + falsenegative);
    a = (truepositive + truenegative) / (truepositive + truenegative + falsepositive + falsenegative);
end