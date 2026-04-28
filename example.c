#include "lim.h"

#include <stdio.h>

int main(void) {
    lim_ctx ctx;
    char event[512];

    lim_init(&ctx);
    lim_add_rule(&ctx, "temperature", LIM_OP_GT, 80.0, LIM_LEVEL_WARN, "temperature.high");
    lim_add_rule(&ctx, "queue.depth", LIM_OP_GT, 1000.0, LIM_LEVEL_ERROR, "queue.backpressure");

    if (lim_sample(&ctx, "temperature", 82.4, event, sizeof(event)) > 0) {
        puts(event);
    }

    if (lim_sample(&ctx, "queue.depth", 1402.0, event, sizeof(event)) > 0) {
        puts(event);
    }

    return ctx.error_count ? 1 : 0;
}
