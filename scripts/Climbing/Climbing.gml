function Climbing(){
if (touch_wall_left)
{
	lefttrue = true;
	righttrue = false;
    Climbs = true;
}
else
if (touch_wall_right)
{
	righttrue = true;
	lefttrue = false;
	Climbs = true;
}
else
{lefttrue = false;
righttrue = false;}
}
