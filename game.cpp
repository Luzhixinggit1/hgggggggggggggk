#include<stdio.h>
#include<graphics.h>
#include<time.h>
#define WINDOW_WIDTH   500
#define WINDOW_HEIGHT  800
#define PIC_SIZE       100
#define ROW            WINDOW_WIDTH/PIC_SIZE
#define COL            WINDOW_HEIGHT/PIC_SIZE             

IMAGE img;
IMAGE picImg[ROW*COL];
int   map[ROW][COL]; /*= {*/
	//{ 0, 1, 2, 3, 4, 5, 6, 7 },
	//{ 8, 9, 10, 11, 12, 13, 14, 15 },
	//{ 16, 17, 18, 19, 20, 21, 22, 23 },
	//{ 24, 25, 26, 27, 28, 29, 30, 31 },
	//{ 32, 33, 34, 35, 36, 37, 38, 39 }};

//初始化二维数组
void RandArry()//打乱二维数组
{
	//定义一个一维数组
	int temp[ROW*COL];
	for (int i = 0; i < ROW*COL; i++)
	{
		temp[i] = i;
	}
	int num;//一维数组的下标
	int maxSize = ROW*COL;//temp数组的大小
	for (int i = 0; i < ROW; i++)
	{
		for (int j = 0; j < COL; j++)
		{
			num = rand() % maxSize;//num从0-39；
			map[i][j] = temp[num];

			//从选中的下标开始 把后面的元素往前移动一个单位
			for (int tep = num; tep < maxSize-1; tep++)
			{
				temp[tep] = temp[tep + 1];
			}
			maxSize--;
		}
	}
	/*for (int i = 0; i < ROW; i++)
	{
		for (int j = 0; j < COL; j++)
		{
			map[i][j] = rand() % (ROW*COL);
		}
	}*/
}

void GameInit()
{
	RandArry();
	//初始化图片（切割）
	loadimage(&img, L"./picture/99.jpg", WINDOW_WIDTH, WINDOW_HEIGHT);
	//切割图片
	SetWorkingImage(&img);//设置绘图环境
	int n = 0;

	for (int i = 0; i < ROW; i++)
	{
		for (int j = 0; j < COL; j++)
		{
			getimage(&picImg[n], i*PIC_SIZE, j*PIC_SIZE, PIC_SIZE, PIC_SIZE);//从一个环境设备中取得图像
			n++;
		}
	}

	SetWorkingImage(NULL);
	//读取一张白色图片加载到最后一张
	loadimage(&picImg[ROW*COL - 1], L"./picture/1.jpg", PIC_SIZE, PIC_SIZE);

}
//绘制界面
void DrawMap()
{
	//把二维数组的元素跟图片绑定在一起
	for (int i = 0; i < ROW; i++)
	{
		for (int j = 0; j < COL; j++)
		{
			putimage(i*PIC_SIZE, j*PIC_SIZE, &picImg[map[i][j]]);//从0开始到39
			//switch (map[i][j])//map[i][j]=0-39
			//{

			//}
		}
	}
}
void PlayGame()
{
	int row, col;//鼠标点击的图片对应的数组元素
	int blankR, blankC;//空白图片对应的数组下标
	int blankX, blankY;
	MOUSEMSG msg = { 0 };
//确定空白图片的下标
	for (int i = 0; i < ROW; i++)
	{
		for (int j = 0; j < COL; j++)
		{
			if (map[i][j] == ROW*COL - 1)
			{
				blankR = i;
				blankC = j;
			}
		}
	}
	blankX = blankR*PIC_SIZE;
	blankY = blankC*PIC_SIZE;
	//确定鼠标点击的下标
	msg = GetMouseMsg();
	switch (msg.uMsg)
	{
	case WM_LBUTTONDOWN:
		row = msg.x / PIC_SIZE;
		col = msg.y / PIC_SIZE;

		if ((msg.x > blankX-PIC_SIZE&&msg.x<blankX&&msg.y>blankY&&msg.y<blankY+PIC_SIZE) || (msg.x>blankX &&msg.x<blankX+PIC_SIZE&&msg.y>blankY-PIC_SIZE&&msg.y<blankY) || (msg.x>blankX + PIC_SIZE&&msg.x<blankX+2*PIC_SIZE&&msg.y>blankY&&msg.y<blankY+PIC_SIZE) || (msg.x>blankX&&msg.x<blankX+PIC_SIZE&&msg.y>blankY+PIC_SIZE&&msg.y < blankY+PIC_SIZE*2))
		{
			map[blankR][blankC] = map[row][col];
			map[row][col] = ROW*COL - 1;
		}
		break;
	default:
		break;
		
	}

	//玩游戏的过程，当鼠标点下去的时候程序确定鼠标点的是哪一张图片
	//点中的图片是不是和空白图片是相邻的
	//确定空白图片到底在哪里
	//交换二维数组的两个元素
}
int main(void)
{
	initgraph(WINDOW_WIDTH, WINDOW_HEIGHT);
	//加载图片
	srand((unsigned int)time(NULL));
	GameInit();


		while (1)
	{
		DrawMap();
		PlayGame();
	}
	getchar();
	closegraph();
	return 0;
}