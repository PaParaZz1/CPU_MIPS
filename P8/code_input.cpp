#include<stdio.h>
int main()
{
    FILE *fp,*fp1,*fp2;
    fp=fopen("c:\\Users\\nyz\\Desktop\\p8\\p8\\IM.coe","w");
    fp1=fopen("c:\\Users\\nyz\\Desktop\\p8\\p8\\code.txt","r");
    fp2=fopen("c:\\Users\\nyz\\Desktop\\p8\\p8\\code_handler.txt","r");
    fprintf(fp,"memory_initialization_radix=16;\nmemory_initialization_vector=\n");
    char code[10];
    int k=0;
    while(fscanf(fp1,"%s",code)!=EOF){
        k++;
        
        fprintf(fp,"%s,\n",code);
    }
    printf("%d\n",k);
    for(int i=k;i<1120;++i)
        fprintf(fp,"00000000,\n");
    k=0;
    while(fscanf(fp2,"%s",code)!=EOF){
        k++;
        fprintf(fp,"%s,\n",code);
    }
    fprintf(fp,"00000000;\n");
    printf("%d\n",k);
    return 0;
}
