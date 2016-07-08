function u = claw(q)
qd = q(1);
qc = q(2);

persistent u_save;
persistent uOld;
persistent uOldOld;
persistent e;
persistent eOld;
persistent eOldOld;

if isempty(uOld)
   uOld = 0;
end
if isempty(uOldOld)
   uOldOld = 0;
end
if isempty(e)
   e = 0;
end
if isempty(eOld)
   eOld = 0;
end
if isempty(eOldOld)
   eOldOld = 0;
end
if isempty(u_save)
   u_save = 0;
end

uOldOld = uOld;
uOld = u_save;
eOldOld = eOld;
eOld = e;
e = qd - qc;
u = 1.818*uOld - 0.8182*uOldOld + 10080*e - 17090*eOld + 7236*eOldOld;
u_save = u;

end

