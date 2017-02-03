#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define X_MAX 10.0    /* 定義域の最大値 */
#define X_MIN -10.0   /* 定義域の最小値 */
#define Y_MAX 10.0    /* 定義域の最大値 */
#define Y_MIN -10.0   /* 定義域の最小値 */
#define X_RANGE (fabs(X_MAX)+fabs(X_MIN))
#define Y_RANGE (fabs(Y_MAX)+fabs(Y_MIN))
#define SAME 0.0000001 /* 探索点の動作チェック */


void usage();
double f(double x, double y);
double pd_x(double x, double y);
double pd_y(double x, double y);


void usage(){
  fprintf(stderr," Usage : prompt> ./a.out random-seed\n");
  exit(0);
}

/* 関数 f(x,y)
 *    入力された x に対する z=f(x,y) の値を求め，返す．
 */
double f(double x, double y) {
  double z;

/** 以下の式を編集して完成させよ(1) **/
//  z = x;
  z = x*x + y*y;

  return( z );
}

/* f(x,y)/dx
 *    z=f(x,y) の微分値(偏微分値)を求め，返す．
 */
double pd_x(double x, double y) {
  double z_dx;

  /** 以下の式を編集して完成させよ(2-1) **/
//  z_dx = 1;
  z_dx = 2*x;

  return( z_dx );
}

/* f(x,y)/dy
 *    z=f(x,y) の微分値(偏微分値)を求め，返す．
 */
double pd_y(double x, double y) {
  double z_dy;

  /** 以下の式を編集して完成させよ(2-2) **/
//  z_dy = 0;
  z_dy = 2*y;

  return( z_dy );
}


int main(int argc, char **argv) {
    double x,y,_x,_y;
    int    i;
    double alpha = 0.0;
    /** alpha: 学習レート
     * [課題] 正の範囲内で任意に設定し，それに伴う探索点の移動を観察せよ．
     * [option] alpha を固定にすることのメリット・デメリット、
     *   変動させる場合の変動方法やそのメリット・デメリット等、
     *   学習効率に関係する側面について検討してみよう。
     */
    int term_cond = 1000; /* 終了条件（繰り返し数） */

    int seed;
    if( argc != 3 ){
        usage();
    }else{
        seed = atoi(argv[1]);
		alpha = atof(argv[2]);
        srand(seed);
        rand();
    }

    /* step1. 探索の初期位置を設定 */
    x = X_MIN + X_RANGE * (double)rand()/RAND_MAX;
    y = Y_MIN + Y_RANGE * (double)rand()/RAND_MAX;
//    printf("step 0 x %.10f y %.10f f(x,y) %.10f %e\n", x,y,f(x,y),f(x,y));

    for (i = 1; i < term_cond; i++) {
        _x = x; _y = y;

        /* step2. 次の探索場所へ移動 */
        x = x - alpha*pd_x(x,y);
        y = y - alpha*pd_y(x,y);

        /* 終了条件2:定義域を外れた場合 */
        if( (x <= X_MIN) || (x >= X_MAX) || (y <= Y_MIN) || (y >= Y_MAX) ){
            fflush(stdout);
            fprintf(stderr,"FINISH 2 step %d x_rearched_to %.10f y_reached_to %.10f f(x,y) %.10f\n",i,x,y,f(x,y));
            break;
        }
        /* 終了条件3:殆ど探索点が動いていない場合 */
        if( ((_x-SAME < x) && (x < _x+SAME)) &&
            ((_y-SAME < y) && (y < _y+SAME)) ){
            fflush(stdout);
//           fprintf(stderr,"FINISH 3 step %d x and y were not updated.\n",i);
            break;
        }
//        printf("step %d x %.10f y %.10f f(x,y) %.10f %e\n",i,x,y,f(x,y),f(x,y));
    }
        printf("%f,%d\n",alpha,i);
    if( i >= term_cond ){
        fflush(stdout);
//    fprintf(stderr,"FINISH 1 step %d this trial couldn't be search enough under the term_cond=%d.\n",i,term_cond);
    }
    return 0;
}
