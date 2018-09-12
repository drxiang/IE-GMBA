function premium = get_bond_premium(interest_coverage)

[~,~,coverage_raw] = xlsread('AHP-English_Templates.xls', 'Coverage');
coverage_interval = cell2mat(coverage_raw(6:19, 1));
premium_tab = cell2mat(coverage_raw(6:19, 4));

coverage_interval_resize = coverage_interval * ones(size(interest_coverage));
interest_coverage_resize = ones(size(coverage_interval)) * interest_coverage;

premium = premium_tab(sum(interest_coverage_resize >= coverage_interval_resize));
premium = premium';
