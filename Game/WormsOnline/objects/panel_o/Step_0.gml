if create=1
{
if alpha <= 1
alpha+=0.2
}
else
{
with (but)
create=0
if alpha >= 0
alpha-=0.1

if alpha <= 0
instance_destroy()
}

