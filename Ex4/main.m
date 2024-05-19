clc
clear all 
close all

load('ws_homework_3_2024.mat')

%sampling time
Ts=0.001;

%inertia matrix
I_b=diag([1.2416 1.2416 2*1.2416]);

%gravitational acceleratio
g=9.81;

%mass
m=1.5;

%e3 vector
e3=[0; 0; 1];

%EA
phi=attitude.signals.values(:,1);
theta=attitude.signals.values(:,2);
psi=attitude.signals.values(:,3);

%time
t=length(phi);

%time derivative of EA
phi_dot=attitude_vel.signals.values(:,1);
theta_dot=attitude_vel.signals.values(:,2);
psi_dot=attitude_vel.signals.values(:,3);
etab_dot=[phi_dot theta_dot psi_dot];

%control inputs
Tau=tau.signals.values;
ut=thrust.signals.values;

% Rotation matrix with respect world frame
for i=1:t
    R_b(i).mat=[cos(theta(i))*cos(psi(i)) sin(phi(i))*sin(theta(i))*cos(psi(i))-cos(phi(i))*sin(psi(i)) cos(phi(i))*sin(theta(i))*cos(psi(i))+sin(phi(i))*sin(psi(i));
    cos(theta(i))*sin(psi(i)) sin(phi(i))*sin(theta(i))*sin(psi(i))+cos(phi(i))*cos(psi(i)) cos(phi(i))*sin(theta(i))*sin(psi(i))-sin(phi(i))*cos(psi(i));
    -sin(theta(i)) sin(phi(i))*cos(theta(i)) cos(phi(i))*cos(theta(i))];
end

% Q matrix
for i=1:t
    Q(i).mat=[1 0 -sin(theta(i)); 
        0 cos(phi(i)) cos(theta(i))*sin(phi(i)); 
        0 -sin(phi(i)) cos(theta(i))*cos(phi(i))];
end

% Q_dot matrix
for i=1:t
    Q_dot(i).mat=[0 0 -theta_dot(i)*cos(theta(i)); 
        0 -phi_dot(i)*sin(phi(i)) (theta_dot(i)*-sin(theta(i))*sin(phi(i)))+(cos(theta(i))*phi_dot(i)*cos(phi(i))); 
        0 phi_dot(i)*-cos(phi(i)) (theta_dot(i)*-sin(theta(i))*cos(phi(i)))+(cos(theta(i))*phi_dot(i)*-sin(phi(i)))];
end

% M matrix
for i=1:t
    M(i).mat=(Q(i).mat)'*I_b*Q(i).mat;
end

% C matrix
for i=1:t
    C(i).mat=(Q(i).mat')*skew(Q(i).mat*etab_dot(i,:)')*I_b*Q(i).mat+(Q(i).mat')*I_b*Q_dot(i).mat;
end

%Momentum
for i=1:t
    q(i).vec=[m*eye(3) zeros(3) ; zeros(3) M(i).mat]*[linear_vel.signals.values(i,:)' ; attitude_vel.signals.values(i,:)'];
end


%Required to bring the signal q on simulink
for i=1:length(q)
    q1(i)=q(i).vec(1);
    q2(i)=q(i).vec(2);
    q3(i)=q(i).vec(3);
    q4(i)=q(i).vec(4);
    q5(i)=q(i).vec(5);
    q6(i)=q(i).vec(6);
end

for i=1:t
    L(i).vec=[m*g*e3-ut(i)*R_b(i).mat*e3 ; C(i).mat'*etab_dot(i,:)'+Q(i).mat'*Tau(i,:)'];
end

for i=1:length(q)
    L1(i)=L(i).vec(1);
    L2(i)=L(i).vec(2);
    L3(i)=L(i).vec(3);
    L4(i)=L(i).vec(4);
    L5(i)=L(i).vec(5);
    L6(i)=L(i).vec(6);
end

q_sim=[q1;q2;q3;q4;q5;q6];
L_sim=[L1;L2;L3;L4;L5;L6];

%selezionare grado del filtro
r=input('Insert the order of the estimation: ');

%K_i gains are extracted with this function, which uses butterworth
%coefficient for filtering
k=coeff(r);
%simulation time
T=30;
simulink=sim("disturbance_estimator.slx");
time=simulink.estimate.Time;
fe_hat=[simulink.estimate.data(1,:);simulink.estimate.data(2,:);simulink.estimate.data(3,:)];
taue_hat=[simulink.estimate.data(4,:);simulink.estimate.data(5,:);simulink.estimate.data(6,:)];
display('The estimated values of the disturbances are: ')
display('force along x: ')
fe_hat(1,end)
display('force along y: ')
fe_hat(2,end)
display('force along z: ')
fe_hat(3,end)
display('torque along x: ')
taue_hat(1,end)
display('torque along y: ')
taue_hat(2,end)
display('torque along z: ')
taue_hat(3,end)
%% Plot forze F1, F2, F3
y_forces = {fe_hat(1,:), fe_hat(2,:), fe_hat(3,:)};
x_forces = {time, time, time};
x_label_latex_forces = {'time [s]', 'time [s]', 'time [s]'};
y_label_latex_forces = {'$f_x$ [N]', '$f_y$ [N]', '$f_z$ [N]'};
subplot_titles_forces = {'Force $x$', 'Force $y$', 'Force $z$'};
pdf_name_forces = 'Forces_Plot.pdf';

% Numero di subplot forze
num_subplot_forces = numel(y_forces);

% Chiamata alla funzione personal_subplot per le forze
h_forces = personal_subplot(x_forces, y_forces, x_label_latex_forces, y_label_latex_forces, pdf_name_forces, num_subplot_forces, subplot_titles_forces);

%% Plot momenti M1, M2, M3
y_moments = {taue_hat(1,:), taue_hat(2,:), taue_hat(3,:)};
x_moments = {time, time, time};
x_label_latex_moments = {'time [s]', 'time [s]', 'time [s]'};
y_label_latex_moments = {'$\tau_x$ [Nm]', '$\tau_y$ [Nm]', '$\tau_z$ [Nm]'};
subplot_titles_moments = {'Torque $x$', 'Torque $y$', 'Torque $z$'};
pdf_name_moments = 'Moments_Plot.pdf';

% Numero di subplot momenti
num_subplot_moments = numel(y_moments);

% Chiamata alla funzione personal_subplot per i momenti
h_moments = personal_subplot(x_moments, y_moments, x_label_latex_moments, y_label_latex_moments, pdf_name_moments, num_subplot_moments, subplot_titles_moments);



%% mass estimation
%per calcolare la massa reale posso considerare l'equazione lineare
%dell'UAV considerando nulla l'accekerazione lineare nulla a regime
true_m=m+fe_hat(end)/g

%% uncomment when m=true_m
%h_force = personal_plot(x_forces{3}, y_forces{3}, x_label_latex_forces{3}, y_label_latex_forces{3}, 'mass_correction.pdf', subplot_titles_forces{3});

