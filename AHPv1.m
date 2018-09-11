debt_ratio = 0.01:0.01:0.99;
% debt_ratio = 0.3;
D_E = debt_ratio ./ (1 - debt_ratio);

EBIT_u = 954.8e6;
existing_debt = 13.9e6;
capital = (362.2e6 + existing_debt)/.3;
excess_cash = 233e6;
P = 30; % price per share
total_share = 155.5e6;

Kd = 0.14; % debt interest rate 
tax_rate = 0.48; % tax rate

beta_asset = 0.8;
R_f = 0.14;
R_m = 0.07;

divident_prefer = 0.4e6;
payout_ratio = 0.6;

% FCF
debt = capital * debt_ratio;
additional_debt = debt - existing_debt;
total_repurchase = additional_debt + excess_cash;

EBIT = EBIT_u - excess_cash * Kd;

interest = debt * Kd;
EBT = EBIT - interest;
FCF = EBT * (1-tax_rate); 

% earning_shareholder = FCF - divident_prefer;
% dividend = earning_shareholder * payout_ratio;
% reduction_share = total_repurchase / P;
% share_outstanding = total_share - reduction_share;
% DPS = dividend ./ share_outstanding; % dividend per share

% cost of equity
beta_e = beta_asset * (1 + (1-tax_rate) .* D_E);
Ke = R_f + beta_e .* R_m;

% cost of debt
interest_coverage = EBIT ./ interest;
bond_premium = get_bond_premium(interest_coverage);
Kd = R_f + bond_premium;

WACC = (1-tax_rate) * Kd .* debt_ratio + ...
    Ke .* (1-debt_ratio);

V_L = FCF ./ WACC;

figure
hold on
plot(Kd, 'b')
plot(Ke, 'r')
plot(WACC, 'k')
xlabel('Debt ratio')
axis([0, 100, 0.1, 0.3])
legend('Cost of debt', 'Cost of equity', 'WACC')

figure
hold on
plot(V_L, 'k')
plot(EBT, 'b')
plot(interest, 'r')
plot(FCF, 'm')
xlabel('Debt ratio')
axis([0, 100, 0, 3.5e9])
legend('Firm value', 'EBT', 'Interest', 'Free cash flow')
