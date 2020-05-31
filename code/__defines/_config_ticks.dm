#define LIFE_TICK 4 //Deciseconds per life tick interval.
#define LIFE_TICK_SLOW 8 //Deciseconds per slow life tick interval.
#define LIFE_TICKS_PER_SLOW_LIFE_TICKS (LIFE_TICK_SLOW / LIFE_TICK)
#define AI_TICK 0.5


#define CLIENT_TICK 1 //FRAMES per life tick interval
#define CLIENT_TICK_SLOW FPS_SERVER //FRAMES per slow life tick internval
#define CLIENT_TICKS_PER_SLOW_CLIENT_TICKS (CLIENT_TICK_SLOW / CLIENT_TICK)

#define PROJECTILE_TICK 1 //Ticks per projectile tick interval
#define STATUS_TICK 1 //Ticks per status effect interval