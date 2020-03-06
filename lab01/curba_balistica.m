% Curba balistica - Miscarea unui proiectil cu frecare fluida
% Preoteasa Mircea-Costin + Tulba-Lecu Theodor-Gabriel
% 311CA
clear;

g = 9.80665; % m/s^2; acceleratia gravitationala

m = 1.2; % kg; masa proiectilului
v0 = 950; % m/s; viteza initiala
alpha0 = 40; % grade; unghiul de lansare initial

t0 = 0; % s; momentul lansarii
tf = 2 * v0 * sind(alpha0) / g; % s; momentul final

N = 250; % numarul de diviziuni
t = linspace(t0, tf,  N); 
delta_t = t(2) - t(1); % pasul de timp

b1 = m * g /v0; b2 = m * g / v0^2; % estimare a coef de frecare

x = zeros(1, N); % coordonata pe axa Ox
y = zeros(1, N); % coordonata pe axa Oy

vx = zeros(1, N); % viteza pe axa Ox
vy = zeros(1, N); % viteza pe axa Oy

vx(1) = v0 * cosd(alpha0);
vy(1) = v0 * sind(alpha0);

for i = 1:N
    const = 1 - delta_t / m * ( b1 + b2 * sqrt(vx(i)^2 + vy(i)^2));
    vx(i+1) = vx(i) * const;
    vy(i+1) = vy(i) * const - g* delta_t;
    
    x(i+1) = x(i) + vx(i) * delta_t;
    y(i+1) = y(i) + vy(i) * delta_t;
    
    if(y(i+1) < 0)
        N = i;
        break
    end
end

figure(1);
plot(t(1:N), vx(1:N), '-r', t(1:N), vy(1:N), '-b');
xlabel('t/s');
ylabel('(viteza) m/s');
title('Legile vitezelor');
grid;
legend('vx','vy', 'Location', 'SouthWest');
axis([0, t(N), min(vx(N), vy(N)), max(vx(1), vy(1))]);

scale = 1e3;
figure(2);
disp(y)
plot(x(1:N)/scale, y(1:N)/scale, '-k', 'LineWidth', 2);
xlabel('x/km');
ylabel('y/km');
title('Traiectoria');
grid;
axis equal;
axis([0, x(N)/scale, 0, 1.1* max(y) / scale]);

disp(['Timpul de zbor este: ', num2str(t(N)), ' s.']);
disp (['Bataia este: ', num2str(x(N)/scale), ' km.']);
disp (['Altitudinea maxima este: ', num2str(max(y)/scale), ' km.']);