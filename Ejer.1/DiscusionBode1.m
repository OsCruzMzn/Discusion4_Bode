% =========================================================================
% DIAGRAMA DE BODE Y MÁRGENES DE ESTABILIDAD
% Función: G1(s) = 10^8*(s + 2*pi*100e3) / (s*(s + 2*pi*90e3)*(s + 2*pi*140e3))
% =========================================================================
clear; clc; close all;

% 1. Definición del sistema
% Frecuencias angulares de las singularidades
w_z1 = 2 * pi * 100e3;
w_p1 = 2 * pi * 90e3;
w_p2 = 2 * pi * 140e3;

num = 10^8 * [1, w_z1];
den = conv([1, 0], conv([1, w_p1], [1, w_p2]));
G = tf(num, den);

% 2. Opciones de gráfica
opts = bodeoptions;
opts.FreqUnits = 'Hz';
opts.Grid = 'on';
opts.Title.String = 'Diagrama de Bode y Puntos de Corte';

% 3. Graficar diagramas con márgenes automáticos
figure('Name', 'Diagrama de Bode', 'Color', 'w');
margin(G, opts);

% 4. Extracción numérica e impresión de márgenes
[Gm, Pm, Wcg, Wcp] = margin(G);
Gm_dB = 20*log10(Gm);

f_pc_Hz = Wcg / (2*pi);
f_gc_Hz = Wcp / (2*pi);

fprintf('=========================================================\n');
fprintf('                 PUNTOS DE CORTE Y MÁRGENES              \n');
fprintf('=========================================================\n');
fprintf('Corte en -180 deg (w_pc) : %.4f rad/s (%.4f Hz)\n', Wcg, f_pc_Hz);
fprintf(' -> Margen de Ganancia   : %.2f dB\n', Gm_dB);
fprintf('---------------------------------------------------------\n');
fprintf('Corte en 0 dB (w_gc)     : %.4f rad/s (%.4f Hz)\n', Wcp, f_gc_Hz);
fprintf(' -> Margen de Fase       : %.2f deg\n', Pm);
fprintf('=========================================================\n');
if Gm_dB > 0 && Pm > 0
    fprintf('JUICIO DE ESTABILIDAD: El sistema es ESTABLE.\n');
else
    fprintf('JUICIO DE ESTABILIDAD: El sistema es INESTABLE.\n');
end
fprintf('=========================================================\n');
