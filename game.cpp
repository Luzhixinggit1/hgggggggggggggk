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

//��ʼ����ά����
void RandArry()//���Ҷ�ά����
{
	//����һ��һά����
	int temp[ROW*COL];
	for (int i = 0; i < ROW*COL; i++)
	{
		temp[i] = i;
	}
	int num;//һά������±�
	int maxSize = ROW*COL;//temp����Ĵ�С
	for (int i = 0; i < ROW; i++)
	{
		for (int j = 0; j < COL; j++)
		{
			num = rand() % maxSize;//num��0-39��
			map[i][j] = temp[num];

			//��ѡ�е��±꿪ʼ �Ѻ����Ԫ����ǰ�ƶ�һ����λ
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
	//��ʼ��ͼƬ���и
	loadimage(&img, L"./picture/99.jpg", WINDOW_WIDTH, WINDOW_HEIGHT);
	//�и�ͼƬ
	SetWorkingImage(&img);//���û�ͼ����
	int n = 0;

	for (int i = 0; i < ROW; i++)
	{
		for (int j = 0; j < COL; j++)
		{
			getimage(&picImg[n], i*PIC_SIZE, j*PIC_SIZE, PIC_SIZE, PIC_SIZE);//��һ�������豸��ȡ��ͼ��
			n++;
		}
	}

	SetWorkingImage(NULL);
	//��ȡһ�Ű�ɫͼƬ���ص����һ��
	loadimage(&picImg[ROW*COL - 1], L"./picture/1.jpg", PIC_SIZE, PIC_SIZE);

}
//���ƽ���
void DrawMap()
{
	//�Ѷ�ά�����Ԫ�ظ�ͼƬ����һ��
	for (int i = 0; i < ROW; i++)
	{
		for (int j = 0; j < COL; j++)
		{
			putimage(i*PIC_SIZE, j*PIC_SIZE, &picImg[map[i][j]]);//��0��ʼ��39
			//switch (map[i][j])//map[i][j]=0-39
			//{

			//}
		}
	}
}
void PlayGame()
{
	int row, col;//�������ͼƬ��Ӧ������Ԫ��
	int blankR, blankC;//�հ�ͼƬ��Ӧ�������±�
	int blankX, blankY;
	MOUSEMSG msg = { 0 };
//ȷ���հ�ͼƬ���±�
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
	//ȷ����������±�
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

	//����Ϸ�Ĺ��̣���������ȥ��ʱ�����ȷ�����������һ��ͼƬ
	//���е�ͼƬ�ǲ��ǺͿհ�ͼƬ�����ڵ�
	//ȷ���հ�ͼƬ����������
	//������ά���������Ԫ��
}
int main(void)
{
	initgraph(WINDOW_WIDTH, WINDOW_HEIGHT);
	//����ͼƬ
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