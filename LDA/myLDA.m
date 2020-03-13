%% Our data
data=load('iris'); % IRIS database
X = data.Inputs';
N = size(X, 2); % Column length of the sets

%% Settings
S = 50; % Sets - Here you can edit
C = 3; % Classes - Here you can edit

%% Create ui and u
ui = zeros(C, N);
u = zeros(1, N);
for i = 1:C
  for j = 1:N
    for k = 1:S
      ui(i, j) = ui(i, j) + X(k+S*(i-1), j)/S; % Sum all sets of one class into one mean.
    end
    u(1, j) = u(1, j) + ui(i, j)/C; % Sum all the means from the sets into one big mean
  end
end


%% Create Sw and Sb
Sb = zeros(N,N);
Sw = zeros(N,N);
H = zeros(N,1);
L = zeros(N,S);
for i = 1:C
  for j = 1:N
    H(j) = ui(i, j) - u(1, j);
  end
  Sb = Sb + S*H*H'; % Muliply with amout of sets

  for k = 1:S
    for j = 1:N
      L(j, k) = X(k+S*(i-1), j) - ui(i, j);
    end
  end
  Sw = Sw + L*L';
end

%% Print Sb and Sw
Sb
Sw

%% Compute for hand
W1 = X(1:50, :);
W2 = X(51:100, :);
W3 = X(101:150, :);
u1 = mean(W1)';
u2 = mean(W2)';
u3 = mean(W3)';
u = mean([u1';u2';u3'])';

SB = S*(u1 - u)*(u1-u)' + S*(u2 - u)*(u2-u)' + S*(u3 - u)*(u3-u)'
SW = (W1' - u1)*(W1' -u1)' + (W2' - u2)*(W2' - u2)' + (W3' - u3)*(W3' - u3)'


%% Compute 
[W, LAMBDA] = eig(inv(SW)*SB)
Wopt = (W*SB*W)/(W*SW*W)
