//
//  PickPhotoViewController.m
//  同城
//
//  Created by xthink2 on 16/1/28.
//  Copyright © 2016年 xthink4. All rights reserved.
//

#import "PickPhotoViewController.h"
#import "NewPhotoCollectionViewCell.h"
#import "NewPhotoModel.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
static NSInteger count = 0;
@interface PickPhotoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong)NSMutableArray *mutableAssets;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,assign)int picNum;
@property (strong,nonatomic) UIImagePickerController *imagePicker;
@property (strong,nonatomic) NSMutableArray *selectPic;
@property (strong,nonatomic) NSMutableArray *selectOriginalPic;
@property (strong,nonatomic) ALAssetsLibrary *assetLibrary;
@property (strong,nonatomic) UILabel *prompt;
@property (strong,nonatomic) UIView *bigImage;
@end

@implementation PickPhotoViewController
- (ALAssetsLibrary *)assetLibrary
{
    if (!_assetLibrary) {
        _assetLibrary =[[ALAssetsLibrary alloc]init];
    }
    return _assetLibrary;
}
- (UIView *)bigImage
{
    if (!_bigImage) {
        _bigImage =[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(WINDOW), HEIGHT(WINDOW))];
        _bigImage.backgroundColor =[UIColor blackColor];
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(remove)];
        _bigImage.userInteractionEnabled =YES;
        [_bigImage addGestureRecognizer:tap];
    }
    return _bigImage;
}
- (UILabel*)prompt
{
    if (!_prompt) {
        _prompt =[[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT(WINDOW)-94, WIDTH(WINDOW), 30)];
        _prompt.textColor =[UIColor orangeColor];
        _prompt.textAlignment = NSTextAlignmentCenter;
        _prompt.backgroundColor =[UIColor whiteColor];
    }
    return _prompt;
}
- (UIImagePickerController *)imagePicker
{
    if (!_imagePicker) {
        _imagePicker =[[UIImagePickerController alloc]init];
    }
    return _imagePicker;
}
- (NSMutableArray *)mutableAssets
{
    if (!_mutableAssets) {
        _mutableAssets =[NSMutableArray array];
    }
    return _mutableAssets;
}
- (NSMutableArray *)selectPic
{
    if (!_selectPic) {
        _selectPic =[NSMutableArray array];
    }
    return _selectPic;
}
- (NSMutableArray *)selectOriginalPic
{
    if (!_selectOriginalPic) {
        _selectOriginalPic =[NSMutableArray array];
    }
    return _selectOriginalPic;
}
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake((WIDTH(WINDOW)-25)/4.0, (WIDTH(WINDOW)-25)/4.0);
        layout.minimumInteritemSpacing = 5;
        layout.minimumLineSpacing = 5;
        _collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(5, 3, WIDTH(WINDOW)-10, HEIGHT(WINDOW)-95) collectionViewLayout:layout];
        _collectionView.delegate=self;
        _collectionView.dataSource =self;
        [_collectionView registerNib: [UINib nibWithNibName:@"NewPhotoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionViewCell"];
        _collectionView.backgroundColor =Color(241.0f, 241.0f, 241.0f, 1.0f);
        
    }
    return _collectionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent =NO;
    [self.view addSubview:self.collectionView];
    self.picNum =0;
    self.prompt.text =[NSString stringWithFormat:@"可选(%d)张,已选(%d)张!",self.mostNum,self.picNum];
    [self.view addSubview:self.prompt];
    [self setNavigationBarRightBtnWitBtnTitle:@"确定"];
    [self getAllPictures];
    // Do any additional setup after loading the view.
}
-(void)getAllPictures {
    
    NSMutableArray *assetURLDictionaries = [[NSMutableArray alloc] init];
    NSMutableArray *assetGroups = [[NSMutableArray alloc] init];
    __block PickPhotoViewController *tempSelf = self;
    __block NSMutableArray *tempAssetGroups = assetGroups;
    [self.assetLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop){
        if (group != nil) {
            count = [group numberOfAssets];
            __block int groupNum = 0;
            
            [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop) {
                if(asset != nil) {
                    ++ groupNum;
                    if([[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                        [assetURLDictionaries addObject:[asset valueForProperty:ALAssetPropertyURLs]];
                        NewPhotoModel *phoModel=[[NewPhotoModel alloc]init];
                        phoModel.isSelected=NO;
                        phoModel.asset =asset;
                        [tempSelf.mutableAssets addObject:phoModel];
                        if (self.mutableAssets.count == count) {
                            [tempSelf allPhotosCollected:nil];
                        }
                    }
                }
            }];
            [tempAssetGroups addObject:group];
        }else{
            [tempSelf allPhotosCollected:nil];
        }
    }failureBlock:^(NSError *error){
        if (error.code == -3311) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"用户已拒绝该应用程序访问相册"
                                                           message:@"请打开 设置-隐私-照片 来进行设置"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil, nil];
            [alert show];
        }
        NSLog(@"%@",error);
        NSLog(@"There is an error");
    }];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.mutableAssets.count+1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"CollectionViewCell";
    NewPhotoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (indexPath.row==0) {
        cell.imageView.image = [UIImage imageNamed:@"矢量智能对象-拷贝"];
        cell.selectImageView.hidden=YES;
        cell.selectBtnClickBlock=^(BOOL isSelect)
        {
            [self creatCamera];
        };
        return cell;
    }
    NewPhotoModel *phoModel = self.mutableAssets[indexPath.row-1];
    UIImage *image = [UIImage imageWithCGImage:[phoModel.asset thumbnail]];
    [cell.imageView setImage:image];
    
    if (phoModel.isSelected) {
        cell.selectImageView.image=[UIImage imageNamed:@"duihao"];
    }else{
        cell.selectImageView.image=[UIImage imageNamed:@"fangkuang"];
    }
    cell.selectImageView.hidden=NO;
    cell.selectBtn.selected=phoModel.isSelected;
    cell.selectBtnClickBlock=^(BOOL isSelect)
    {
        if (isSelect) {
            if (self.picNum  < self.mostNum) {
                self.picNum++;
                phoModel.isSelected=isSelect;
                [_collectionView reloadData];
                self.prompt.text =[NSString stringWithFormat:@"可选(%d)张,已选(%d)张!",self.mostNum,self.picNum];
            }else{
                    NSLog(@"最多选着%d张图片",self.mostNum);
//                NSString *string =[NSString stringWithFormat:@"最多选着%d张图片",self.mostNum];
//                [self CreatereminderView:string];
                
                }
        }else{
            self.picNum--;
            phoModel.isSelected=isSelect;
            self.prompt.text =[NSString stringWithFormat:@"可选(%d)张,已选(%d)张!",self.mostNum,self.picNum];
        }
        [_collectionView reloadData];
    };
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row ==0) {
        [self creatCamera];
    }else{
        NewPhotoModel *photo =self.mutableAssets[indexPath.row-1];
        [self showBigImage:photo];
    }
}

- (void)showBigImage:(NewPhotoModel *)newPhotoModel
{
    CGSize size =[[newPhotoModel.asset defaultRepresentation]dimensions];
    
    float a =WIDTH(WINDOW)/HEIGHT(WINDOW);
    float b =size.width/size.height;
    if (a >= b) {
        // h
        float width =size.width*HEIGHT(WINDOW)/size.height;
        UIImageView *image =[[UIImageView alloc]initWithFrame:CGRectMake((WIDTH(WINDOW)-width)/2, 0, width, HEIGHT(WINDOW))];
        image.image = [UIImage imageWithCGImage:[[newPhotoModel.asset defaultRepresentation] fullScreenImage]];
        image.userInteractionEnabled =NO;
        [self.bigImage addSubview:image];
        
    }else{
        // w
        float height =size.height*WIDTH(WINDOW)/size.width;
        
        UIImageView *image =[[UIImageView alloc]initWithFrame:CGRectMake(0, (HEIGHT(WINDOW)-height)/2, WIDTH(WINDOW), height)];
        image.image = [UIImage imageWithCGImage:[[newPhotoModel.asset defaultRepresentation] fullScreenImage]];
        image.userInteractionEnabled =NO;
        [self.bigImage addSubview:image];
    }
    [[UIApplication sharedApplication].keyWindow addSubview:self.bigImage];
    
}
- (void)remove{
    for (id a in self.bigImage.subviews) {
        [a removeFromSuperview];
    }
    [self.bigImage removeFromSuperview];
}






-(void)allPhotosCollected:(NSMutableArray *)mutableAsset{
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)creatCamera
{
    
    NSString *mediaType = AVMediaTypeVideo;
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    
    if(authStatus == ALAuthorizationStatusRestricted || authStatus == ALAuthorizationStatusDenied){
        NSLog(@"1");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"用户已拒绝该应用程序访问相机"
                                                       message:@"请打开 设置-隐私-相机 来进行设置"
                                                      delegate:nil
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil, nil];
        [alert show];
        
    }else{
        NSLog(@"2");
        [self.imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        NSString *requiredMediaType = ( NSString *)kUTTypeImage;
        NSArray *arrMediaTypes=[NSArray arrayWithObjects: requiredMediaType,nil];
        [self.imagePicker setMediaTypes:arrMediaTypes];
        self.imagePicker.allowsEditing = YES;// 设置是否可以管理已经存在的图片或者视频
        [self.imagePicker setDelegate:self];// 设置代理
        
        [self.navigationController presentViewController:self.imagePicker animated:YES completion:nil];
    }
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"Picker returned successfully.");
    UIImage *theImage1 = nil;
    UIImage *theImage2 = nil;
    theImage1 = [info objectForKey:UIImagePickerControllerOriginalImage];
    theImage2 = [self compressImageWith:theImage1 width:150 height:150];
    // 保存图片到相册中
    SEL selectorToCall = @selector(imageWasSavedSuccessfully:didFinishSavingWithError:contextInfo:);
    UIImageWriteToSavedPhotosAlbum(theImage1, self,selectorToCall, NULL);
    [self.selectOriginalPic addObject:theImage1];
    [self.selectPic addObject:theImage2];
}
// 保存图片后到相册后，调用的相关方法，查看是否保存成功
- (void) imageWasSavedSuccessfully:(UIImage *)paramImage didFinishSavingWithError:(NSError *)paramError contextInfo:(void *)paramContextInfo{
    if (paramError == nil){
        NSLog(@"Image was saved successfully.");
        [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
        self.returenPickedPhoto(self.selectPic,self.selectOriginalPic);
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    } else {
        NSLog(@"An error happened while saving the image.");
        NSLog(@"Error = %@", paramError);
    }
}

- (void)NavigationBarRightBarButtonAction:(UIButton *)tmpBarBtn
{
    for (NewPhotoModel *photo in self.mutableAssets) {
        if (photo.isSelected) {
            UIImage *image =[UIImage imageWithCGImage:[[photo.asset defaultRepresentation] fullScreenImage]];
            UIImage *image2 = [UIImage imageWithCGImage:[photo.asset thumbnail]];
            [self.selectOriginalPic addObject:image];
            [self.selectPic addObject:image2];
            if (self.selectPic.count == self.picNum ) {
                self.returenPickedPhoto(self.selectPic,self.selectOriginalPic);
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }
}
- (UIImage *)compressImageWith:(UIImage *)image width:(float)width height:(float)height
{
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    
    float widthScale = imageWidth /width;
    float heightScale = imageHeight /height;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    if (widthScale > heightScale) {
        [image drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
    }
    else {
        [image drawInRect:CGRectMake(0, 0, width , imageHeight /widthScale)];
    }
    
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return newImage;
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
