local X=0
print("preloader...")
while(not rs.getInput('left')) do turtle.forward() X=X+1 if(X> 250) then os.reboot()end end shell.run('c-client') 