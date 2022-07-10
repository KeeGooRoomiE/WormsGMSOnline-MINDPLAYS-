if create=1
{
if alpha <= 0.7
alpha+=0.2
}
else
{
if alpha >= 0
alpha-=0.1

if alpha <= 0
instance_destroy()
}

