    1 rem *** start
    3 p=9:rem palette size
    4 a=200:rem fade delay
    5 b=5:rem color delay
    6 l=10:rem flicker delay
    7 k=50:rem black flicker delay
    8 s$="                                        "
    9 z$=s$+s$
   10 q$="       {rvof}                          {rvon}       "
   30 rem *** triangle init
   31 dim t$(20)
   32 for i=1 to 20
   33 l$=left$(s$,20-i)
   34 t$(i)="{rvon}"+l$+"{rvof}"+chr$(169)+left$(s$,(i-1)*2)+chr$(223)+"{rvon}"+l$
   35 next
   40 rem *** circle init
   41 dim c$(21)
   42 for i=1 to 10
   43 read x
   44 c$(i)="{rvon}"+left$(s$, x)+"{rvof}"+left$(s$,40-2*x)+"{rvon}"+left$(s$,x)
   45 c$(22-i)=c$(i)
   46 next
   47 c$(11)=c$(10)
   50 rem *** circle smoothing
   54 c$(1)="{rvon}"+left$(s$, 14)+"{rvof}{CBM-U}{CBM-U}"+left$(s$,8)+"{CBM-U}{CBM-U}{rvon}"+left$(s$,14)
   55 c$(21)="{rvon}"+left$(s$, 14)+"{rvof}{CBM-I}{CBM-I}"+left$(s$,8)+"{CBM-I}{CBM-I}{rvon}"+left$(s$,14)
   56 c$(2)="{rvon}"+left$(s$, 12)+"{rvof}{CBM-U}"+left$(s$,14)+"{CBM-U}{rvon}"+left$(s$,12)
   57 c$(20)="{rvon}"+left$(s$, 12)+"{rvof}{CBM-I}"+left$(s$,14)+"{CBM-I}{rvon}"+left$(s$,12)
   58 c$(6)="{rvon}"+left$(s$, 8)+"{rvof}{CBM-K}"+left$(s$,22)+"{CBM-L}{rvon}"+left$(s$,8)
   59 c$(8)="{rvon}"+left$(s$, 7)+"{rvof}{CBM-K}"+left$(s$,24)+"{CBM-L}{rvon}"+left$(s$,7)
   60 c$(16)=c$(6):c$(9)=c$(8):c$(13)=c$(8):c$(14)=c$(8)
   80 rem *** palette init
   81 for i=1 to p:read pi(i):next
   82 for i=1 to p:read po(i):next
   83 for i=1 to p:read bi(i):next
   84 for i=1 to p:read bo(i):next
   85 for i=1 to p:read ri(i):next
   86 for i=1 to p:read ro(i):next
   87 for i=1 to p:read gi(i):next
   88 for i=1 to p:read g2(i):next
   95 rem *** black fill
   96 poke646,0
   97 poke53280,0
   98 poke53281,0
   99 print "{clr}{blk}{rvon}";
  100 rem *** main loop
  103 gosub 211:rem white
  104 gosub 190:rem aav1
  106 gosub 160
  108 gosub 220
  110 gosub 290
  112 gosub 200:rem aav2
  114 gosub 160
  116 gosub 220
  118 gosub 290
  119 gosub 212:rem blue
  120 gosub 150:rem triangle
  122 gosub 160
  124 gosub 220
  126 gosub 290
  127 gosub 213:rem red
  128 gosub 170:rem square
  130 gosub 160
  132 gosub 220
  134 gosub 290
  135 gosub 214:rem green
  136 gosub 180:rem circle
  138 gosub 160
  140 gosub 220
  142 gosub 290
  146 goto 100
  150 rem *** draw triangle
  151 print z$;
  152 for i=1to20:print t$(i);:next
  153 print z$;
  154 return
  160 rem *** fill bottom of screen
  162 fori=1983to2023:pokei,160:next
  164 return
  170 rem *** draw square
  171 print z$;
  173 for i=1to20:print q$;:next
  174 print z$;
  175 return
  180 rem *** draw circle
  181 print z$;
  182 for i=1to21:print c$(i);:next
  183 print s$;
  184 return
  190 rem *** draw aavikko 1
  191 print "{rvon}"+z$;
  192 for i=1 to 20
  194 print "{rvon}"+left$(s$,i+6)+"aavikko"+left$(s$,27-i);
  195 next
  196 print z$;
  198 return
  200 rem *** draw aavikko 2
  201 print "{rvon}"+z$;
  202 for i=1 to 20
  203 print "{rvon}"+left$(s$,27-i)+"aavikko"+left$(s$,i+6);
  205 next
  206 print z$;
  208 return
  210 rem *** palette swaps
  211 for i=1 to p:f(i)=pi(i):o(i)=po(i):next:return
  212 for i=1 to p:f(i)=bi(i):o(i)=bo(i):next:return
  213 for i=1 to p:f(i)=ri(i):o(i)=ro(i):next:return
  214 for i=1 to p:f(i)=gi(i):o(i)=g2(i):next:return
  220 rem *** fade in
  221 for d=1 to k
  222 if int(rnd(1)*10)=1 then poke53281,f(2):fori=1tod/5:next:poke53281,f(1)
  223 next
  229 f(p+1)=f(p-1)
  230 for i=1 to p
  235 for x=1 to l
  240 poke 53281,f(i)
  241 poke 53281,f(i+1)
  245 next
  247 poke 53281,f(p)
  250 for d=1 to b:next d
  260 next
  270 return
  290 rem *** fade out
  300 for d=1 to a
  301 if int(rnd(1)*15)=1 then poke53281,o(2):for i=1 to 10:next:poke53281,o(1)
  302 next
  304 o(p+1)=o(p-1)
  305 for i=1 to p
  306 for x=1 to l
  307 poke 53281,o(i)
  308 poke 53281,o(i+1)
  309 next
  310 poke 53281,o(p)
  311 next
  312 for d=1 to k
  313 if int(rnd(1)*15)=1 then poke53281,f(2):fori=1to(k-d)/5:next:poke53281,f(1)
  314 next
  316 return
 1000 data 15,12,11,10,9,8,8,8,7,7
 1009 rem *** palette white
 1010 data 0,11,6,12,14,3,13,15,1
 1020 data 1,15,13,3,14,12,6,11,0
 1029 rem *** palette blue
 1030 data 0,11,6,12,14,3,14,12,6
 1040 data 6,12,14,3,14,12,6,11,0
 1049 rem *** palette red
 1050 data 0,11,2,12,10,8,10,12,2
 1060 data 2,12,10,8,10,12,2,11,0
 1069 rem *** palette green
 1070 data 0,11,6,12,5,3,13,3,5
 1080 data 5,3,13,3,5,12,6,11,0
