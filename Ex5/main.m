clc
close all
clear all
simulink=sim("geometric_control_template.slx");
time=simulink.geom_contr.time;
err_p=simulink.geom_contr.signals.values(1:3,:);
dot_err_p=simulink.geom_contr.signals.values(4:6,:);
err_R=simulink.geom_contr.signals.values(7:9,:);
err_W=simulink.geom_contr.signals.values(10:12,:);
tau=simulink.geom_contr.signals.values(13:15,:);
uT=simulink.geom_contr.signals.values(16,:);
p=simulink.geom_contr.signals.values(17:19,:);
rpy=simulink.geom_contr.signals.values(20:22,:);
omega_bb=simulink.geom_contr.signals.values(23:25,:);
p_dot=simulink.geom_contr.signals.values(26:28,:);
p_ddot=simulink.geom_contr.signals.values(29:31,:);
omega_dot=simulink.geom_contr.signals.values(32:34,:);
%% Linear errors plot
t = {time, time, time};
err = {err_p(1,:), err_p(2,:), err_p(3,:)};

% Creazione delle celle per le etichette degli assi
x_label_latex = {'time [s]', 'time [s]', 'time [s]'};
y_label_latex  = {'$e_x$ [m]', '$e_y$ [m]', '$e_z$ [m]'};
% Nomi per ogni subplot

subplot_titles= {'Position Error on $x$', 'Position Error on $y$', 'Position Error on $z$'};

% Nome del file PDF da esportare
pdf_name = 'Linear Position Errors.pdf';

% Numero di subplot
num_subplot = 3;

 
h = personal_subplot(t, err, x_label_latex, y_label_latex, pdf_name, num_subplot, subplot_titles);


dot_err = {dot_err_p(1,:), dot_err_p(2,:), dot_err_p(3,:)};

% Creazione delle celle per le etichette degli assi
x_label_latex = {'time [s]', 'time [s]', 'time [s]'};
y_label_latex  = {'$\dot{e}_x$ [m/s]', '$\dot{e}_y$ [m/s]', '$\dot{e}_z$ [m/s]'};
% Nomi per ogni subplot

subplot_titles= {'Velocity Error on $x$', 'Velocity Error on $y$', 'Velocity Error on $z$'};

% Nome del file PDF da esportare
pdf_name = 'Linear Velocity Errors.pdf';

% Numero di subplot
num_subplot = 3;

 
h = personal_subplot(t, dot_err, x_label_latex, y_label_latex, pdf_name, num_subplot, subplot_titles);

%% Angular errors plot
ang_err = {err_R(1,:), err_R(2,:), err_R(3,:)};

% Creazione delle celle per le etichette degli assi
x_label_latex = {'time [s]', 'time [s]', 'time [s]'};
y_label_latex  = {'$e_R(1)$', '$e_R(2)$', '$e_R(3)$'};
% Nomi per ogni subplot

subplot_titles= {'First component', 'Second component', 'Third component'};

% Nome del file PDF da esportare
pdf_name = 'Angular Errors.pdf';

% Numero di subplot
num_subplot = 3;

 
h = personal_subplot(t, ang_err, x_label_latex, y_label_latex, pdf_name, num_subplot, subplot_titles);

w_err = {err_W(1,:), err_W(2,:), err_W(3,:)};

% Creazione delle celle per le etichette degli assi
x_label_latex = {'time [s]', 'time [s]', 'time [s]'};
y_label_latex  = {'$e_{Wx}$ [rad/s]', '$e_{Wy}$ [rad/s]', '$e_{Wz}$ [rad/s]'};
% Nomi per ogni subplot

subplot_titles= {'Angular velocity error around $x$', 'Angular velocity error around $y$', 'Angular velocity error around $z$'};

% Nome del file PDF da esportare
pdf_name = 'Angular velocity Errors.pdf';

% Numero di subplot
num_subplot = 3;

 
h = personal_subplot(t, w_err, x_label_latex, y_label_latex, pdf_name, num_subplot, subplot_titles);

%% pose

position = {p(1,:), p(2,:), p(3,:)};

% Creazione delle celle per le etichette degli assi
x_label_latex = {'time [s]', 'time [s]', 'time [s]'};
y_label_latex  = {'$x$ [m]', '$y$ [m]', '$z$ [m]'};
% Nomi per ogni subplot

subplot_titles= {'Trajectory along $x$', 'Trajectory along $y$', 'Trajectory along $z$'};

% Nome del file PDF da esportare
pdf_name = 'Position.pdf';

% Numero di subplot
num_subplot = 3;

 
h = personal_subplot(t, position, x_label_latex, y_label_latex, pdf_name, num_subplot, subplot_titles);


EA = {rpy(1,:), rpy(2,:), rpy(3,:)};

% Creazione delle celle per le etichette degli assi
x_label_latex = {'time [s]', 'time [s]', 'time [s]'};
y_label_latex  = {'$\phi$ [rad]', '$\theta$ [rad]', '$\psi$ [rad]'};
% Nomi per ogni subplot

subplot_titles= {'Roll', 'Pitch', 'Yaw'};

% Nome del file PDF da esportare
pdf_name = 'RPY.pdf';

% Numero di subplot
num_subplot = 3;

 
h = personal_subplot(t, EA, x_label_latex, y_label_latex, pdf_name, num_subplot, subplot_titles);

%% control actions
input = {tau(1,:), tau(2,:), tau(3,:),uT(:)};
t2={time,time,time,time}; 
% Creazione delle celle per le etichette degli assi
x_label_latex = {'time [s]', 'time [s]', 'time [s]', 'time [s]'};
y_label_latex  = {'$\tau_x$ [Nm]', '$\tau_y$ [Nm]', '$\tau_z$ [Nm]','$u_T$ [N]'};
% Nomi per ogni subplot

subplot_titles= {'Torque around $x$', 'Torque around $y$', 'Torque around $z$','Total thrust'};

% Nome del file PDF da esportare
pdf_name = 'Control inputs.pdf';

 
h = personal_subplot2(t2, input, x_label_latex, y_label_latex, pdf_name,2,2, subplot_titles);


%% velocities
vel = {p_dot(1,:), p_dot(2,:), p_dot(3,:)};

% Creazione delle celle per le etichette degli assi
x_label_latex = {'time [s]', 'time [s]', 'time [s]'};
y_label_latex  = {'$\dot{x}$ [m/s]', '$\dot{y}$ [m/s]', '$\dot{z}$ [m/s]'};
% Nomi per ogni subplot

subplot_titles= {'Velocity along $x$', 'Velocity along $y$', 'Velocity along $z$'};

% Nome del file PDF da esportare
pdf_name = 'Linear velocities.pdf';

% Numero di subplot
num_subplot = 3;

 
h = personal_subplot(t, vel, x_label_latex, y_label_latex, pdf_name, num_subplot, subplot_titles);

omega = {omega_bb(1,:), omega_bb(2,:), omega_bb(3,:)};

% Creazione delle celle per le etichette degli assi
x_label_latex = {'time [s]', 'time [s]', 'time [s]'};
y_label_latex = {'$\omega_{bx}^b$ [rad/s]', '$\omega_{by}^b$ [rad/s]', '$\omega_{bz}^b$ [rad/s]'};
% Nomi per ogni subplot

subplot_titles= {'Angular velocity along $x$', 'Angular velocity along $y$', 'Angular velocity along $z$'};

% Nome del file PDF da esportare
pdf_name = 'Angular velocities.pdf';

% Numero di subplot
num_subplot = 3;

 
h = personal_subplot(t, omega, x_label_latex, y_label_latex, pdf_name, num_subplot, subplot_titles);
%% accelerations
acc = {p_ddot(1,:), p_ddot(2,:), p_ddot(3,:)};

% Creazione delle celle per le etichette degli assi
x_label_latex = {'time [s]', 'time [s]', 'time [s]'};
y_label_latex  = {'$\ddot{x}$ [m/$s^2$]', '$\ddot{y}$ [m/$s^2$]', '$\ddot{z}$ [m/$s^2$]'};
% Nomi per ogni subplot

subplot_titles= {'Acceleration along $x$', 'Acceleration along $y$', 'Acceleration along $z$'};

% Nome del file PDF da esportare
pdf_name = 'Linear acceleration.pdf';

% Numero di subplot
num_subplot = 3;

 
h = personal_subplot(t, acc, x_label_latex, y_label_latex, pdf_name, num_subplot, subplot_titles);

omega_do = {omega_dot(1,:), omega_dot(2,:), omega_dot(3,:)};

% Creazione delle celle per le etichette degli assi
x_label_latex = {'time [s]', 'time [s]', 'time [s]'};
y_label_latex = {'$\dot{\omega}_{bx}^b$ [rad/$s^2$]', '$\dot{\omega}_{by}^b$ [rad/$s^2$]', '$\dot{\omega}_{bz}^b$ [rad/$s^2$]'};
% Nomi per ogni subplot

subplot_titles= {'Angular acc. along $x$', 'Angular acc. along $y$', 'Angular acc. along $z$'};

% Nome del file PDF da esportare
pdf_name = 'Angular accelerations.pdf';

% Numero di subplot
num_subplot = 3;

 
h = personal_subplot(t, omega_do, x_label_latex, y_label_latex, pdf_name, num_subplot, subplot_titles);