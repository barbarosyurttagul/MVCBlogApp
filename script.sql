USE [master]
GO
/****** Object:  Database [PersonalBlog]    Script Date: 26.7.2016 02:39:30 ******/
CREATE DATABASE [PersonalBlog]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PersonalBlog', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\PersonalBlog.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'PersonalBlog_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\PersonalBlog_log.ldf' , SIZE = 3136KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [PersonalBlog] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PersonalBlog].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PersonalBlog] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PersonalBlog] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PersonalBlog] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PersonalBlog] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PersonalBlog] SET ARITHABORT OFF 
GO
ALTER DATABASE [PersonalBlog] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PersonalBlog] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [PersonalBlog] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PersonalBlog] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PersonalBlog] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PersonalBlog] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PersonalBlog] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PersonalBlog] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PersonalBlog] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PersonalBlog] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PersonalBlog] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PersonalBlog] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PersonalBlog] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PersonalBlog] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PersonalBlog] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PersonalBlog] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PersonalBlog] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PersonalBlog] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PersonalBlog] SET RECOVERY FULL 
GO
ALTER DATABASE [PersonalBlog] SET  MULTI_USER 
GO
ALTER DATABASE [PersonalBlog] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PersonalBlog] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PersonalBlog] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PersonalBlog] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'PersonalBlog', N'ON'
GO
USE [PersonalBlog]
GO
/****** Object:  Table [dbo].[Article]    Script Date: 26.7.2016 02:39:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Article](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ArticleName] [nvarchar](250) NULL,
	[ArticleContent] [nvarchar](max) NULL,
	[PublishDate] [datetime] NULL,
	[CategoryId] [int] NULL,
	[CoverPhotoId] [int] NULL,
	[Displayed] [int] NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_Article] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ArticleTag]    Script Date: 26.7.2016 02:39:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ArticleTag](
	[ArticleId] [int] NOT NULL,
	[TagId] [int] NOT NULL,
 CONSTRAINT [PK_ArticleTag] PRIMARY KEY CLUSTERED 
(
	[ArticleId] ASC,
	[TagId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Category]    Script Date: 26.7.2016 02:39:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Comment]    Script Date: 26.7.2016 02:39:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MemberId] [nvarchar](128) NULL,
	[ArticleId] [int] NULL,
	[CommentContent] [nvarchar](max) NULL,
	[AddedDate] [datetime] NULL,
	[IsActive] [bit] NULL,
	[ParentCommentId] [int] NULL,
 CONSTRAINT [PK_Comment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Member]    Script Date: 26.7.2016 02:39:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Member](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[Password] [varchar](256) NULL,
	[RegisterDate] [datetime] NULL,
	[NickName] [nvarchar](50) NULL,
	[PhotoId] [int] NULL,
	[IsAdmin] [bit] NULL,
	[IsActive] [bit] NULL,
	[ActivationCode] [uniqueidentifier] NULL,
	[MemberTypeId] [int] NULL,
	[PictureURL] [nvarchar](256) NULL,
 CONSTRAINT [PK_Member_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MemberType]    Script Date: 26.7.2016 02:39:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MemberType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](50) NULL,
 CONSTRAINT [PK_MemberType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Photo]    Script Date: 26.7.2016 02:39:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Photo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[ThumbnailPath] [nvarchar](500) NULL,
	[MediumSizePath] [nvarchar](500) NULL,
	[CoverPicPath] [nvarchar](500) NULL,
	[AddDate] [datetime] NULL,
 CONSTRAINT [PK_Photo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tag]    Script Date: 26.7.2016 02:39:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tag](
	[TagId] [int] IDENTITY(1,1) NOT NULL,
	[TagName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Tag] PRIMARY KEY CLUSTERED 
(
	[TagId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Article] ON 

INSERT [dbo].[Article] ([Id], [ArticleName], [ArticleContent], [PublishDate], [CategoryId], [CoverPhotoId], [Displayed], [Active]) VALUES (30, N'Softail Slim', N'<h2><strong>A&ccedil;ıklama ve Teknik &Ouml;zellikler</strong></h2>

<p>Softail Slim&reg; motosikletin en g&uuml;zel &ouml;zelliklerini alıp &uuml;zerine yenilerini ekledik. Yeni başlayanlar i&ccedil;in Screamin&rsquo; Eagle&reg; Twin Cam 110&trade; motor ile g&uuml;c&uuml; artırdık. Asker temasını yağ yeşili renk se&ccedil;eneği ile daha ileriye taşıdık. Kalanını ise olabildiğince siyah bıraktık. Siyah &uuml;&ccedil;l&uuml; kelep&ccedil;e ve basamaklar, parlak siyah far lambası halkası,&ccedil;atal kaydırıcı kapakları ve alt &ccedil;atallar. Siyah fren kolları, aynalar ve kesik susturucu ile siyah &uuml;st/alt ikili egzoz. Her santimetresi eski iron tarzına sahip modern g&uuml;&ccedil;le donatıldı. Daha b&uuml;y&uuml;k, daha g&uuml;&ccedil;l&uuml; ve cesur bir model mi arıyorsunuz? Buldunuz bile.</p>
', CAST(0x0000A64F0020CDDD AS DateTime), 2, 1056, 120, 1)
INSERT [dbo].[Article] ([Id], [ArticleName], [ArticleContent], [PublishDate], [CategoryId], [CoverPhotoId], [Displayed], [Active]) VALUES (31, N'Roger Federer', N'<p><strong>Roger Federer</strong>&nbsp;(d. 8 Ağustos 1981&nbsp;<a href="https://tr.wikipedia.org/wiki/Basel">Basel</a>),&nbsp;<a href="https://tr.wikipedia.org/wiki/%C4%B0svi%C3%A7reli">İsvi&ccedil;reli</a>&nbsp;<a href="https://tr.wikipedia.org/wiki/Tenis%C3%A7iler">tenis&ccedil;i</a>. Birinci sırada daha &ouml;nce art arda 237 hafta ve toplamda 302 hafta kalarak bir rekor kırmıştır.</p>

<p>Federer&#39;in 17 Grand Slam şampiyonluğu bulunmaktadır ve erkekler tenis tarihinde bu seviyeye ulaşan ilk tenis oyuncusudur.<a href="https://tr.wikipedia.org/wiki/Roger_Federer#cite_note-3">[3]</a>&nbsp;Tarihte &quot;Kariyer Grand Slam&quot; yapan yedi oyuncudan biridir.<a href="https://tr.wikipedia.org/wiki/Roger_Federer#cite_note-4">[4]</a>&nbsp;<a href="https://tr.wikipedia.org/wiki/Roger_Federer#cite_note-5">[5]</a>&nbsp;Ocak 2010 itibariyle art arda 23 Grand Slam yarı finali oynarak kendisinden &ouml;nceki rekoru yaklaşık olarak ikiye katlamıştır.<a href="https://tr.wikipedia.org/wiki/Roger_Federer#cite_note-6">[6]</a>&nbsp;Ama Roland Garros 2010 da &ccedil;eyrek finalde elendiği i&ccedil;in son bulmuştur. Federer 25&nbsp;<a href="https://tr.wikipedia.org/wiki/Grand_Slam_(tenis)">Grand Slam</a>&nbsp;finalinde oynayan ilk oyuncudur. Federer toplamda 35 Grand Slam yarı finali oynayan tenis tarihindeki tek kişidir. 11 kez &uuml;st &uuml;ste Grand Slam finali oynayarak &ouml;nemli bir rekora daha adını yazdırmıştır. Federer 2004 Wimbledon itibariyle ard arda 36 Grand Slam &ccedil;eyrek finali oynamıştır ve bu serisi 2013 Wimbledon 2. Turunda&nbsp;<a href="https://tr.wikipedia.org/w/index.php?title=Sergiy_Stakhovsky&amp;action=edit&amp;redlink=1">Sergiy Stakhovsky</a>&#39;e yenildiği i&ccedil;in son bulmuştur.2012 Amerika A&ccedil;ık&#39;ta 23. kez 1 numaralı seribaşı olarak&nbsp;<a href="https://tr.wikipedia.org/wiki/Pete_Sampras">Pete Sampras</a>&#39;ın rekorunu kırmıştır.<a href="https://tr.wikipedia.org/wiki/Roger_Federer#cite_note-7">[7]</a>&nbsp;Tenisteki bu başarılarından dolayı, d&ouml;rt kez &uuml;st &uuml;ste Laureus World Sportsman of the Year &ouml;d&uuml;l&uuml;n&uuml; kazanmıştır.Federer,emekli ve aktif tenis oyuncuları,&ouml;nemli tenis &ccedil;evreleri tarafından tarihin gelmiş ge&ccedil;miş en iyi tenis oyuncusu olarak g&ouml;r&uuml;lmektedir.<a href="https://tr.wikipedia.org/wiki/Roger_Federer#cite_note-TennisChannel-8">[8]</a><a href="https://tr.wikipedia.org/wiki/Roger_Federer#cite_note-9">[9]</a><a href="https://tr.wikipedia.org/wiki/Roger_Federer#cite_note-10">[10]</a><a href="https://tr.wikipedia.org/wiki/Roger_Federer#cite_note-11">[11]</a><a href="https://tr.wikipedia.org/wiki/Roger_Federer#cite_note-12">[12]</a><a href="https://tr.wikipedia.org/wiki/Roger_Federer#cite_note-13">[13]</a><a href="https://tr.wikipedia.org/wiki/Roger_Federer#cite_note-14">[14]</a><a href="https://tr.wikipedia.org/wiki/Roger_Federer#cite_note-15">[15]</a><a href="https://tr.wikipedia.org/wiki/Roger_Federer#cite_note-16">[16]</a><a href="https://tr.wikipedia.org/wiki/Roger_Federer#cite_note-17">[17]</a><a href="https://tr.wikipedia.org/wiki/Roger_Federer#cite_note-18">[18]</a><a href="https://tr.wikipedia.org/wiki/Roger_Federer#cite_note-19">[19]</a><a href="https://tr.wikipedia.org/wiki/Roger_Federer#cite_note-20">[20]</a><a href="https://tr.wikipedia.org/wiki/Roger_Federer#cite_note-21">[21]</a>&nbsp;<a href="https://tr.wikipedia.org/wiki/Avustralya_A%C3%A7%C4%B1k_Tenis_Turnuvas%C4%B1">Avustralya A&ccedil;ık Tenis Turnuvası</a>&#39;nı d&ouml;rt defa,&nbsp;<a href="https://tr.wikipedia.org/wiki/Wimbledon_Tenis_Turnuvas%C4%B1">Wimbledon</a>&nbsp;tenis turnuvasını yedi defa,&nbsp;<a href="https://tr.wikipedia.org/wiki/Amerika_A%C3%A7%C4%B1k_Tenis_Turnuvas%C4%B1">Amerika A&ccedil;ık Tenis Turnuvası</a>&#39;nı beş defa&nbsp;<a href="https://tr.wikipedia.org/wiki/Fransa_A%C3%A7%C4%B1k">Fransa A&ccedil;ık</a>&nbsp;(Roland Garros tenis turnuvası) bir defa olmak &uuml;zere toplam 17&nbsp;<a href="https://tr.wikipedia.org/wiki/Grand_Slam_(tenis)">Grand Slam</a>&nbsp;kazanmıştır.<a href="https://tr.wikipedia.org/wiki/Roger_Federer#cite_note-22">[22]</a>&nbsp;Federer tenis tarihinin en &ccedil;ok kazanan ismidir.<a href="https://tr.wikipedia.org/wiki/Roger_Federer#cite_note-23">[23]</a>&nbsp;Federer 4 Grand Slamdede en az 5 kere final g&ouml;ren tek oyuncudur.</p>
', CAST(0x0000A64A002164E0 AS DateTime), 1, 1057, 100, 1)
INSERT [dbo].[Article] ([Id], [ArticleName], [ArticleContent], [PublishDate], [CategoryId], [CoverPhotoId], [Displayed], [Active]) VALUES (32, N'Mishka- Give You All The Love', N'<p>I&#39;ll give you all the love I&#39;ve got cause you&#39;re here tonight,<br />
I&#39;ll give you all the love I&#39;ve got and baby it&#39;s alright<br />
We&#39;re sailing into the harbour<br />
Moonlight shining bright over the water<br />
Been at sea for so long , drifting in a haze<br />
Been at sea for so long, now I want to stay<br />
I&#39;ll give you all the love I&#39;ve got cause you&#39;re here tonight<br />
I&#39;ll give you all the love I&#39;ve got and baby it&#39;s alright</p>
', CAST(0x0000A64900227C16 AS DateTime), 3, 1058, 97, 1)
INSERT [dbo].[Article] ([Id], [ArticleName], [ArticleContent], [PublishDate], [CategoryId], [CoverPhotoId], [Displayed], [Active]) VALUES (33, N'Sia - Chandelier', N'<p>Party girls don&#39;t get hurt<br />
Can&#39;t feel anything, when will I learn<br />
I push it down, push it down<br />
<br />
I&#39;m the one &quot;for a good time call&quot;<br />
Phone&#39;s blowin&#39; up, ringin&#39; my doorbell<br />
I feel the love, feel the love<br />
<br />
1, 2, 3 1, 2, 3 drink<br />
1, 2, 3 1, 2, 3 drink<br />
1, 2, 3 1, 2, 3 drink<br />
<br />
Throw &#39;em back, till I lose count<br />
<br />
I&#39;m gonna swing from the chandelier, from the chandelier<br />
I&#39;m gonna live like tomorrow doesn&#39;t exist<br />
Like it doesn&#39;t exist</p>
', CAST(0x0000A64C0022FA04 AS DateTime), 3, 1059, 65, 1)
INSERT [dbo].[Article] ([Id], [ArticleName], [ArticleContent], [PublishDate], [CategoryId], [CoverPhotoId], [Displayed], [Active]) VALUES (34, N'EFE AYDAL - Ateistlerin Ahlakı Yoktur Diyenlere', N'<h2><strong>&ldquo;Ateistlerin Ahlakı Yoktur&rdquo; Diyenlere</strong></h2>

<p>Doğru d&uuml;zg&uuml;n bir ateistin &ccedil;ıkarılıp konuşturulmadığı kanallarımızda bazı arkadaşlar rahat&ccedil;a at koşturmaya devam ediyor. En son, ateistlerin ahlakını Allah&rsquo;tan aldığıyla ilgili ş&ouml;yle bir soruya yer verildi:</p>

<ul>
	<li>&ldquo;Ateistler ensestin k&ouml;t&uuml; olduğunu neye dayanarak s&ouml;yleyebilir?&rdquo;</li>
</ul>

<p>İstenen bilgi, nasıl değil hangi sebeple enseste karşı olunduğuymuş. Ve cevap ise onların deyimiyle &ldquo;y&uuml;ce yaratıcı&rdquo;dan alınan ahlak değeriymiş. Bu ifadeye bağlı olarak &ldquo;ateistlerin ahlakı yoktur, &ccedil;&uuml;nk&uuml; ahlakı veren bir varlığa inanmazlar&rdquo; şeklindeki belki de en sık duyduğumuz ve en aptalca arg&uuml;mana değinmek istiyorum.</p>

<p>Yukarıda bizi kontrol eden o hayali varlık hikayelerinin insan uydurması olduğunu fark ettiğimde benim de sorduğum sorulardan birisi ahlakın nereden geldiğiydi. Kısa s&uuml;rede şu sonuca vardım; sadece toplumlarda ya da &uuml;lkelerde değil, b&uuml;y&uuml;k k&uuml;&ccedil;&uuml;k her insan grubunda ahlak sistemi vardır. Buna bazı yerlerde &ldquo;etik&rdquo;, bazı yerlerde &ldquo;racon&rdquo; denir. Sebebi ise; insanın en iyi organize olan hayvan olmasıdır. M&uuml;kemmel bir şekilde organize olabilmek i&ccedil;in yazılı ya da yazısız kurallar koyulması gerekir. Bu kuralların uyulmasını daha etkin hale getirebilmek i&ccedil;in de &ldquo;yukarıdan s&uuml;rekli birinin kontrol ettiği&rdquo; iddiası kullanılmıştır. İşe yarayan, mantıklı kurallar koyup bunları uygulamayı başaran gruplar, diğerlerini sistematik bir şekilde yok eder. Benim de herkes gibi kendi arkadaş &ccedil;evremde uyguladığım kurallarım vardır, ama bu kurallar bana g&ouml;kten inmemiştir. Bu farkı bilmenin &ouml;nemi, 1400 sene &ouml;nceki Arap toplumuna uygun olan ahlak kurallarını eğip b&uuml;kerek g&uuml;n&uuml;m&uuml;ze uyarlamaya &ccedil;alışan, sonra da ateistlere ahlaksız diyen televizyon şarlatanlarının neden haksız olduğunu g&ouml;rebilmemizi sağlar. İsterseniz benim aklımı kullanarak ortaya koyduğum etik kurallarımla &ldquo;y&uuml;ce yaratıcı&rdquo;dan geldiği s&ouml;ylenen ahlak kurallarının bazılarını karşılaştıralım.</p>

<p><strong>Ensest</strong>: &Ouml;ncelikle İslamcı filozof arkadaşın belirttiği ensest konusuna değinelim. Akraba evliliğinin neden sakat &ccedil;ocuğa sebep olduğuna burada tekrar değinmeyeceğim. Kardeş evliliği ise sakat &ccedil;ocuk ihtimalini aşırı arttırdığı i&ccedil;in insanlar &ccedil;oğu i&ccedil;g&uuml;d&uuml;lerine benzer bir şekilde (annelik, şefkat, &ccedil;ocuğu i&ccedil;in kendini feda etmek, vs) kardeşlerine karşı cinsel iticilik duyacak şekilde evrimleşmişlerdir. Tabi filozof arkadaşın sorduğu &ldquo;nasıl&rdquo; değilmiş, &ldquo;kimseye zarar vermedikleri halde, kadın ve erkek ikisi de 18 yaşından b&uuml;y&uuml;k olduğu halde ensest neden ahlaksızlıktır&rdquo;mış. Cevap veriyorum, cinsel olarak bu t&uuml;r farklılığa sahip olan insanlar mevcuttur ve bu ahlaksızlık değildir. Bazı insan nasıl eşcinsel, hayvan sevici, pedofili ise, bazı kardeşler de cinsel olarak birbirine y&ouml;nelir. Bu onların tercihidir. Buna hi&ccedil; kimse bir şey diyemez. O programdaki sunucu &ldquo;ben kardeşimle evliyim, ben ahlaksız mıyım yani?&rdquo; deseydi filozof arkadaş lafı &ccedil;evirmek i&ccedil;in seksen takla atardı. Ahlak &ouml;rneği olarak &ldquo;y&uuml;ce yaratıcı&rdquo;nın lanetlediği bir &ccedil;ok konuyu g&ouml;rmeyip de &ldquo;ensest&rdquo;in kullanılması, ortada ensest ilişki yaşayan &uuml;nl&uuml; bir &ccedil;iftin olmamasındandır.</p>
', CAST(0x0000A64F00242FFB AS DateTime), 22, 1060, 767, 1)
INSERT [dbo].[Article] ([Id], [ArticleName], [ArticleContent], [PublishDate], [CategoryId], [CoverPhotoId], [Displayed], [Active]) VALUES (35, N'Mehmet Mirioğlu', N'<p>gelecekte adından &ccedil;ok fazla s&ouml;z ettireceğini d&uuml;ş&uuml;nd&uuml;ğ&uuml;m gen&ccedil;, zeki ve entelekt&uuml;el yazar.&nbsp;<a href="https://eksisozluk.com/?q=odt%c3%bc">odt&uuml;</a>makina m&uuml;hendisliği &ouml;ğrencisi. daha hen&uuml;z yeni &ccedil;ıkan &quot;<a href="https://eksisozluk.com/?q=tanr%c4%b1%27n%c4%b1n+alfabesi">tanrı&#39;nın alfabesi</a>&quot; isimli harika kitabı da<a href="https://eksisozluk.com/?q=idefix">idefix</a>,&nbsp;<a href="https://eksisozluk.com/?q=d%26r">d&amp;r</a>&nbsp;gibi bilimum kitap satış sitelerinde boy g&ouml;stermiş durumda. piyasa s&uuml;r&uuml;l&uuml;r s&uuml;r&uuml;lmez t&uuml;rkiye&#39;nin &ccedil;ok &ouml;nemli bilim adamı ve felsefecileri olan&nbsp;<a href="https://eksisozluk.com/?q=kerem+canko%c3%a7ak">kerem canko&ccedil;ak</a>,&nbsp;<a href="https://eksisozluk.com/?q=%c3%b6rsan+%c3%b6ymen">&ouml;rsan &ouml;ymen</a>,&nbsp;<a href="https://eksisozluk.com/?q=hasan+ayd%c4%b1n">hasan aydın</a>,&nbsp;<a href="https://eksisozluk.com/?q=erdin%c3%a7+sayan">erdin&ccedil; sayan</a>&nbsp;gibi akademik anlamda m&uuml;thiş isimlerin desteğini de aldı. bu kitap ateistlerin el kitabı niteliğinde, mutlaka herkesin kitaplığında bulunması gereken bir eser.<a href="https://eksisozluk.com/?q=tanr%c4%b1%27n%c4%b1n+alfabesi">tanrı&#39;nın alfabesi</a>, tanrı kanıtlamaları, ateizm ve din gibi hassas konuları bağnaz bir &uuml;slupla ele almak yerine, objektif bir bakış a&ccedil;ısıyla, entelekt&uuml;el d&uuml;r&uuml;stl&uuml;ğe başvurarak, sıra dışı bir şekilde sunuyor.&nbsp;</p>
', CAST(0x0000A62D0025170C AS DateTime), 6, 1061, 245, 1)
SET IDENTITY_INSERT [dbo].[Article] OFF
INSERT [dbo].[ArticleTag] ([ArticleId], [TagId]) VALUES (30, 24)
INSERT [dbo].[ArticleTag] ([ArticleId], [TagId]) VALUES (30, 25)
INSERT [dbo].[ArticleTag] ([ArticleId], [TagId]) VALUES (31, 26)
INSERT [dbo].[ArticleTag] ([ArticleId], [TagId]) VALUES (31, 27)
INSERT [dbo].[ArticleTag] ([ArticleId], [TagId]) VALUES (31, 28)
INSERT [dbo].[ArticleTag] ([ArticleId], [TagId]) VALUES (32, 29)
INSERT [dbo].[ArticleTag] ([ArticleId], [TagId]) VALUES (32, 31)
INSERT [dbo].[ArticleTag] ([ArticleId], [TagId]) VALUES (33, 31)
INSERT [dbo].[ArticleTag] ([ArticleId], [TagId]) VALUES (34, 32)
INSERT [dbo].[ArticleTag] ([ArticleId], [TagId]) VALUES (34, 33)
INSERT [dbo].[ArticleTag] ([ArticleId], [TagId]) VALUES (35, 32)
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([Id], [CategoryName]) VALUES (1, N'Spor')
INSERT [dbo].[Category] ([Id], [CategoryName]) VALUES (2, N'MOTOSİKLET')
INSERT [dbo].[Category] ([Id], [CategoryName]) VALUES (3, N'MÜZİK')
INSERT [dbo].[Category] ([Id], [CategoryName]) VALUES (4, N'Entity Framework')
INSERT [dbo].[Category] ([Id], [CategoryName]) VALUES (5, N'SQL Server')
INSERT [dbo].[Category] ([Id], [CategoryName]) VALUES (6, N'KİTAP')
INSERT [dbo].[Category] ([Id], [CategoryName]) VALUES (22, N'Felsefe')
SET IDENTITY_INSERT [dbo].[Category] OFF
SET IDENTITY_INSERT [dbo].[Comment] ON 

INSERT [dbo].[Comment] ([Id], [MemberId], [ArticleId], [CommentContent], [AddedDate], [IsActive], [ParentCommentId]) VALUES (1017, N'2188ad97-17cc-4457-8607-136b8a6823b7', 34, N'Youtube dan kanalını takip etmenizi tavsiye ederim.', CAST(0x0000A64F00254A6D AS DateTime), 1, NULL)
INSERT [dbo].[Comment] ([Id], [MemberId], [ArticleId], [CommentContent], [AddedDate], [IsActive], [ParentCommentId]) VALUES (1018, N'10153943743693375', 30, N'Bence fortyeight alınmalı', CAST(0x0000A64F00258718 AS DateTime), 1, NULL)
INSERT [dbo].[Comment] ([Id], [MemberId], [ArticleId], [CommentContent], [AddedDate], [IsActive], [ParentCommentId]) VALUES (1019, N'2188ad97-17cc-4457-8607-136b8a6823b7', 30, N'Harleyler çok pahalı :)', CAST(0x0000A64F0025B858 AS DateTime), 1, NULL)
SET IDENTITY_INSERT [dbo].[Comment] OFF
INSERT [dbo].[Member] ([Id], [Name], [LastName], [Email], [Password], [RegisterDate], [NickName], [PhotoId], [IsAdmin], [IsActive], [ActivationCode], [MemberTypeId], [PictureURL]) VALUES (N'10153820922208129', N'Zeliha', N'Tütüncü', N'zelihattnc@yahoo.com', NULL, CAST(0x0000A64301774B66 AS DateTime), NULL, NULL, 0, 1, NULL, 2, N'http://graph.facebook.com/10153820922208129/picture?type=large')
INSERT [dbo].[Member] ([Id], [Name], [LastName], [Email], [Password], [RegisterDate], [NickName], [PhotoId], [IsAdmin], [IsActive], [ActivationCode], [MemberTypeId], [PictureURL]) VALUES (N'10153943743693375', N'Barbaros', N'Yurttagül', N'lordbarbaros@hotmail.com', NULL, CAST(0x0000A64300ED76DC AS DateTime), NULL, NULL, 0, 1, NULL, 2, N'http://graph.facebook.com/10153943743693375/picture?type=large')
INSERT [dbo].[Member] ([Id], [Name], [LastName], [Email], [Password], [RegisterDate], [NickName], [PhotoId], [IsAdmin], [IsActive], [ActivationCode], [MemberTypeId], [PictureURL]) VALUES (N'118931161875535', N'Helen', N'Warmanberg', N'fgxmmbf_warmanberg_1468494708@tfbnw.net', NULL, CAST(0x0000A6430141466B AS DateTime), NULL, NULL, 0, 1, NULL, 2, N'http://graph.facebook.com/118931161875535/picture?type=large')
INSERT [dbo].[Member] ([Id], [Name], [LastName], [Email], [Password], [RegisterDate], [NickName], [PhotoId], [IsAdmin], [IsActive], [ActivationCode], [MemberTypeId], [PictureURL]) VALUES (N'121442864957375', N'Bill', N'McDonaldberg', N'nakopbz_mcdonaldberg_1468514172@tfbnw.net', NULL, CAST(0x0000A64301444942 AS DateTime), NULL, NULL, 0, 1, NULL, 2, N'http://graph.facebook.com/121442864957375/picture?type=large')
INSERT [dbo].[Member] ([Id], [Name], [LastName], [Email], [Password], [RegisterDate], [NickName], [PhotoId], [IsAdmin], [IsActive], [ActivationCode], [MemberTypeId], [PictureURL]) VALUES (N'2188ad97-17cc-4457-8607-136b8a6823b7', N'Yunus', N'Yurttagül', N'lord@gmail.com', N'35-6A-19-2B-79-13-B0-4C-54-57-4D-18-C2-8D-46-E6-39-54-28-AB', CAST(0x0000A63F0120ACB1 AS DateTime), N'aaa', 7, 1, 1, N'74c08ebc-f9d5-47bd-a024-50dee825a96a', 1, NULL)
INSERT [dbo].[Member] ([Id], [Name], [LastName], [Email], [Password], [RegisterDate], [NickName], [PhotoId], [IsAdmin], [IsActive], [ActivationCode], [MemberTypeId], [PictureURL]) VALUES (N'22b7a176-3b8a-4562-9a9c-38316a9f6c62', N'asd', N'sdc', N'sdcsdc', NULL, CAST(0x0000A641002FB264 AS DateTime), NULL, NULL, 0, 0, NULL, 1, NULL)
INSERT [dbo].[Member] ([Id], [Name], [LastName], [Email], [Password], [RegisterDate], [NickName], [PhotoId], [IsAdmin], [IsActive], [ActivationCode], [MemberTypeId], [PictureURL]) VALUES (N'74c08ebc-f9d5-47bd-a024-50dee825a96a', N'Barbar', N'sdfsdf', N'sdfsdfs@sdfsdf.com', N'35-6A-19-2B-79-13-B0-4C-54-57-4D-18-C2-8D-46-E6-39-54-28-AB', CAST(0x0000A63C015DE33C AS DateTime), N'ddd', 6, 1, 1, N'22b7a176-3b8a-4562-9a9c-38316a9f6c62', 1, NULL)
INSERT [dbo].[Member] ([Id], [Name], [LastName], [Email], [Password], [RegisterDate], [NickName], [PhotoId], [IsAdmin], [IsActive], [ActivationCode], [MemberTypeId], [PictureURL]) VALUES (N'b01a2e31-b27e-4f17-ac1d-9f7b43be1d0f', N'BARBAROS', N'YURTTAGÜL', N'barbaros.yurttagul@gmail.com', N'35-6A-19-2B-79-13-B0-4C-54-57-4D-18-C2-8D-46-E6-39-54-28-AB', CAST(0x0000A6440007F86A AS DateTime), NULL, 8, 0, 0, N'7ea38d1c-3b91-4956-82a5-09d869cde0d9', 1, NULL)
SET IDENTITY_INSERT [dbo].[MemberType] ON 

INSERT [dbo].[MemberType] ([Id], [Type]) VALUES (1, N'Normal')
INSERT [dbo].[MemberType] ([Id], [Type]) VALUES (2, N'Facebook')
INSERT [dbo].[MemberType] ([Id], [Type]) VALUES (3, N'Twitter')
SET IDENTITY_INSERT [dbo].[MemberType] OFF
SET IDENTITY_INSERT [dbo].[Photo] ON 

INSERT [dbo].[Photo] ([Id], [Name], [ThumbnailPath], [MediumSizePath], [CoverPicPath], [AddDate]) VALUES (1, N'a', N'/Content/images/-text.png', N'/Content/images/logo.png', N'/Content/images/logo.png', CAST(0x0000A5F800000000 AS DateTime))
INSERT [dbo].[Photo] ([Id], [Name], [ThumbnailPath], [MediumSizePath], [CoverPicPath], [AddDate]) VALUES (2, N'b', N'/Content/images/populerMakale.png', N'/Content/images/logo.png', N'/Content/images/logo.png', CAST(0x0000A5F800000000 AS DateTime))
INSERT [dbo].[Photo] ([Id], [Name], [ThumbnailPath], [MediumSizePath], [CoverPicPath], [AddDate]) VALUES (3, N'c', N'/Content/images/populerMakale.png', N'/Content/images/logo.png', N'/Content/images/logo.png', CAST(0x0000A5F800000000 AS DateTime))
INSERT [dbo].[Photo] ([Id], [Name], [ThumbnailPath], [MediumSizePath], [CoverPicPath], [AddDate]) VALUES (4, N'd', N'/Content/images/populerMakale.png', N'/Content/images/logo.png', N'/Content/images/logo.png', CAST(0x0000A5F800000000 AS DateTime))
INSERT [dbo].[Photo] ([Id], [Name], [ThumbnailPath], [MediumSizePath], [CoverPicPath], [AddDate]) VALUES (5, N'e', N'/Content/images/populerMakale.png', N'/Content/images/logo.png', N'/Content/images/logo.png', CAST(0x0000A5F800000000 AS DateTime))
INSERT [dbo].[Photo] ([Id], [Name], [ThumbnailPath], [MediumSizePath], [CoverPicPath], [AddDate]) VALUES (6, N'f', N'/Content/images/profil.jpg', N'', N'', CAST(0x0000A5F800000000 AS DateTime))
INSERT [dbo].[Photo] ([Id], [Name], [ThumbnailPath], [MediumSizePath], [CoverPicPath], [AddDate]) VALUES (7, N'ss', N'/Content/images/profil2.jpg', NULL, NULL, CAST(0x0000A63F015C1AC3 AS DateTime))
INSERT [dbo].[Photo] ([Id], [Name], [ThumbnailPath], [MediumSizePath], [CoverPicPath], [AddDate]) VALUES (8, N'Avatar', N'/Content/images/avatar.png', NULL, NULL, CAST(0x0000A6440006DF98 AS DateTime))
INSERT [dbo].[Photo] ([Id], [Name], [ThumbnailPath], [MediumSizePath], [CoverPicPath], [AddDate]) VALUES (1056, N'v961tbd4cg51jjah3uev1je20cv6kkfhp2672016.jpg', NULL, NULL, N'/Content/images/v961tbd4cg51jjah3uev1je20cv6kkfhp2672016.jpg', CAST(0x0000A64F0020CD9D AS DateTime))
INSERT [dbo].[Photo] ([Id], [Name], [ThumbnailPath], [MediumSizePath], [CoverPicPath], [AddDate]) VALUES (1057, N'6gzdgbhhg82jdp2fg76bi7ibstv17y9bm2672016.jpg', NULL, NULL, N'/Content/images/6gzdgbhhg82jdp2fg76bi7ibstv17y9bm2672016.jpg', CAST(0x0000A64F002164D9 AS DateTime))
INSERT [dbo].[Photo] ([Id], [Name], [ThumbnailPath], [MediumSizePath], [CoverPicPath], [AddDate]) VALUES (1058, N'c52j6f6tz3vakviipz433knj8gmicor752672016.jpg', NULL, NULL, N'/Content/images/c52j6f6tz3vakviipz433knj8gmicor752672016.jpg', CAST(0x0000A64F00227C11 AS DateTime))
INSERT [dbo].[Photo] ([Id], [Name], [ThumbnailPath], [MediumSizePath], [CoverPicPath], [AddDate]) VALUES (1059, N'bpo2nabrt2z7zpysii3ea5j07gb2o2kv32672016.jpg', NULL, NULL, N'/Content/images/bpo2nabrt2z7zpysii3ea5j07gb2o2kv32672016.jpg', CAST(0x0000A64F0022F9F7 AS DateTime))
INSERT [dbo].[Photo] ([Id], [Name], [ThumbnailPath], [MediumSizePath], [CoverPicPath], [AddDate]) VALUES (1060, N'13obmc7tp61c3e6zjj14nblspbsjlli6c2672016.jpg', NULL, NULL, N'/Content/images/13obmc7tp61c3e6zjj14nblspbsjlli6c2672016.jpg', CAST(0x0000A64F00242FF4 AS DateTime))
INSERT [dbo].[Photo] ([Id], [Name], [ThumbnailPath], [MediumSizePath], [CoverPicPath], [AddDate]) VALUES (1061, N'abdurj9y8muv6ut0u64uvvzf6ol0m45eh2672016.jpg', NULL, NULL, N'/Content/images/abdurj9y8muv6ut0u64uvvzf6ol0m45eh2672016.jpg', CAST(0x0000A64F002516FC AS DateTime))
SET IDENTITY_INSERT [dbo].[Photo] OFF
SET IDENTITY_INSERT [dbo].[Tag] ON 

INSERT [dbo].[Tag] ([TagId], [TagName]) VALUES (24, N'Harley Davidson')
INSERT [dbo].[Tag] ([TagId], [TagName]) VALUES (25, N'Motosiklet')
INSERT [dbo].[Tag] ([TagId], [TagName]) VALUES (26, N'Federer')
INSERT [dbo].[Tag] ([TagId], [TagName]) VALUES (27, N'Tenis')
INSERT [dbo].[Tag] ([TagId], [TagName]) VALUES (28, N'Wimbledon')
INSERT [dbo].[Tag] ([TagId], [TagName]) VALUES (29, N'Mishka')
INSERT [dbo].[Tag] ([TagId], [TagName]) VALUES (31, N'Müzik')
INSERT [dbo].[Tag] ([TagId], [TagName]) VALUES (32, N'Ateizm')
INSERT [dbo].[Tag] ([TagId], [TagName]) VALUES (33, N'Efe Aydal')
SET IDENTITY_INSERT [dbo].[Tag] OFF
ALTER TABLE [dbo].[Article] ADD  CONSTRAINT [DF_Article_PublishDate]  DEFAULT (getdate()) FOR [PublishDate]
GO
ALTER TABLE [dbo].[Comment] ADD  CONSTRAINT [DF_Comment_AddedDate]  DEFAULT (getdate()) FOR [AddedDate]
GO
ALTER TABLE [dbo].[Comment] ADD  CONSTRAINT [DF_Comment_IsActive]  DEFAULT ((0)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Member] ADD  CONSTRAINT [DF_Member_RegisterDate]  DEFAULT (getdate()) FOR [RegisterDate]
GO
ALTER TABLE [dbo].[Member] ADD  CONSTRAINT [DF_Member_IsAdmin]  DEFAULT ((0)) FOR [IsAdmin]
GO
ALTER TABLE [dbo].[Member] ADD  CONSTRAINT [DF_Member_IsActive]  DEFAULT ((0)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Photo] ADD  CONSTRAINT [DF_Photo_AddDate]  DEFAULT (getdate()) FOR [AddDate]
GO
ALTER TABLE [dbo].[Article]  WITH CHECK ADD  CONSTRAINT [FK_Article_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([Id])
GO
ALTER TABLE [dbo].[Article] CHECK CONSTRAINT [FK_Article_Category]
GO
ALTER TABLE [dbo].[Article]  WITH CHECK ADD  CONSTRAINT [FK_Article_Photo] FOREIGN KEY([CoverPhotoId])
REFERENCES [dbo].[Photo] ([Id])
GO
ALTER TABLE [dbo].[Article] CHECK CONSTRAINT [FK_Article_Photo]
GO
ALTER TABLE [dbo].[ArticleTag]  WITH CHECK ADD  CONSTRAINT [FK_ArticleTag_Article] FOREIGN KEY([ArticleId])
REFERENCES [dbo].[Article] ([Id])
GO
ALTER TABLE [dbo].[ArticleTag] CHECK CONSTRAINT [FK_ArticleTag_Article]
GO
ALTER TABLE [dbo].[ArticleTag]  WITH CHECK ADD  CONSTRAINT [FK_ArticleTag_Tag] FOREIGN KEY([TagId])
REFERENCES [dbo].[Tag] ([TagId])
GO
ALTER TABLE [dbo].[ArticleTag] CHECK CONSTRAINT [FK_ArticleTag_Tag]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_Article] FOREIGN KEY([ArticleId])
REFERENCES [dbo].[Article] ([Id])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_Article]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_Member] FOREIGN KEY([MemberId])
REFERENCES [dbo].[Member] ([Id])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_Member]
GO
ALTER TABLE [dbo].[Member]  WITH CHECK ADD  CONSTRAINT [FK_Member_MemberType] FOREIGN KEY([MemberTypeId])
REFERENCES [dbo].[MemberType] ([Id])
GO
ALTER TABLE [dbo].[Member] CHECK CONSTRAINT [FK_Member_MemberType]
GO
ALTER TABLE [dbo].[Member]  WITH CHECK ADD  CONSTRAINT [FK_Member_Photo] FOREIGN KEY([PhotoId])
REFERENCES [dbo].[Photo] ([Id])
GO
ALTER TABLE [dbo].[Member] CHECK CONSTRAINT [FK_Member_Photo]
GO
USE [master]
GO
ALTER DATABASE [PersonalBlog] SET  READ_WRITE 
GO
