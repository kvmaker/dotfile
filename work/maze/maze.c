#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAZE_DEBUG(fmt, arg...) \
    printf("[maze %-4.4d %s] "fmt"\n", __LINE__, __FUNCTION__, #arg)

typedef struct maze
{
    unsigned int  height, width;
    unsigned int  num;
    unsigned int  visted_num;
    unsigned char *visted;  /*0: not visted, 1: visted*/
    unsigned char *map;     /*0, not linked, 2: linked*/
    unsigned int  path_len;
    unsigned int  *path;    /*index*/
} maze;

maze* maze_create(unsigned int height, unsigned int width)
{
    maze *m;

    m = malloc(sizeof(maze));
    if (m == NULL)
    {
        MAZE_DEBUG("malloc fail");
        goto out_0;
    }
    memset(m, 0, sizeof(maze));

    m->height = height;
    m->width  = width;
    m->num    = height * width;
    m->visted = malloc(sizeof(unsigned char) * m->num);
    m->map    = malloc(sizeof(unsigned char) * m->num);
    m->path   = malloc(sizeof(unsigned int)  * m->num);
    if (m->visted == NULL || m->map == NULL || m->path == NULL)
    {
        MAZE_DEBUG("malloc fail");
        goto out_1;
    }
    memset(m->visted, 0, sizeof(unsigned char) * m->num);
    memset(m->map,    0, sizeof(unsigned char) * m->num);
    memset(m->path,   0, sizeof(unsigned int)  * m->num);

    return m;

out_1:
    free(m->path);
    free(m->map);
    free(m->visted);
    free(m);
out_0:
    return NULL;
}
 
void maze_destroy(maze *m)
{
    free(m->path);
    free(m->map);
    free(m->visted);
    free(m);
    return;
}

int maze_rneigh(maze *m, unsigned int self)
{
    int neigh[4];
    int valid_neigh[4];
    int valid_num;
    int i;

    neigh[0] = self - m->width;
    neigh[1] = ((self + 1) % m->width == 0)?-1:self + 1;
    neigh[2] = self + m->width;
    neigh[3] = (self % m->width == 0)?-1:self - 1;

    valid_num = 0;
    for (i = 0; i < 4; i++)
    {
        if (   neigh[i] >= 0 && neigh[i] < m->num
            && m->visted[neigh[i]] == 0)
        {
            valid_neigh[valid_num++] = neigh[i];
        }
    }

    if (valid_num == 0)
        return -1;
    else
        return valid_neigh[rand() % valid_num];
}

void maze_link(maze *m, unsigned int a, unsigned int b)
{
    m->map[a + b * m->width] = 1;
    m->map[b + a * m->width] = 1;
    return;
}

int maze_islink(maze *m, int a, int b)
{
    if (   a >= 0 && a < m->num
        && b >= 0 && b < m->num)
    {
        return (m->map[a + b * m->width] == 1);
    }

    return 0;
}

void maze_path_push(maze *m, unsigned int a)
{
    if (m->path_len == m->num)
    {
        MAZE_DEBUG("no more path space");
        return;
    }

    m->path[m->path_len++] = a;
    return;
}

int maze_path_pop(maze *m)
{
    if (m->path_len == 0)
        return -1;

    return m->path[--m->path_len];
}

void maze_gen(maze *m, unsigned int self)
{
    int rneigh;
    
    m->visted[self] = 1;
    m->visted_num++;
    
    if (m->visted_num == m->num)
        return;

    rneigh = maze_rneigh(m, self);
    if (rneigh == -1)
    {
        int last;
        last = maze_path_pop(m);
        if (last == -1)
        {
            MAZE_DEBUG("bug");
            return;
        }

        return maze_gen(m, last);

    }
    else
    {
        maze_link(m, self, rneigh);
        maze_path_push(m, self);
        return maze_gen(m, rneigh);
    }
}

void maze_show(maze *m)
{
    int y, x;

    for (y = 0; y < m->height; y++)
    {
        for (x = 0; x < m->width; x++)
        {
            printf("%d ", m->map[x + y * m->width]);
        }
        printf("\n");
    }

    return;
}

const static char pattern[2][2] = {{'+', '-'},
                                   {'|', ' '}};

void maze_print(maze *m)
{
    int g_width, g_height;
    int y, x;
    char c;
    int i, ti, li;

    g_width = m->width * 2 + 1;
    g_height= m->height* 2 + 1;
    for (y = 0; y < g_height; y++)
    {
        for (x = 0; x < g_width; x++)
        {
            c = pattern[y % 2][x % 2];
            switch (c)
            {
            case '+':
            case ' ':
                putchar(c);
                break;

            case '-':
                i  = y / 2 * m->width + (x - 1)/2;
                ti = i - m->width;
                if (maze_islink(m, i, ti))
                    putchar(' ');
                else
                    putchar('-');
                break;

            case '|':
                i  = (y - 1) / 2 * m->width + x/2;
                li = (i % m->width == 0)?-1:i - 1;
                if (maze_islink(m, i, li))
                    putchar(' ');
                else
                    putchar('|');
                break;
            }
        }
        putchar('\n');
    }

    return;
}

int main(int argc, char *argv[])
{
    int width, height;
    maze *m;

    if (argc == 3)
    {
        width = atoi(argv[1]);
        height= atoi(argv[2]);
    }
    else
    {
        width = height = 10;
    }

    srand(time(NULL));
    m = maze_create(height, width);
    if (m == NULL)
    {
        MAZE_DEBUG("maze create fail");
        return -1;
    }

    maze_gen(m, 0);
    maze_show(m);
    maze_print(m);

    return 0;
}

