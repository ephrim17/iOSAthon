//
//  HomePage.swift
//  Crickit_iOSAthon
//
//  Created by ephrim.daniel on 26/07/23.
//

import SwiftUI

struct HomePage: View {
    @State var selectedIndex = 0
    
    var body: some View {
        ZStack {
			Color.appBlacks
				.clipShape(BackgroundCard())
            VStack(spacing: 0) {
                
                switch selectedIndex {
                case 0:
                    HomeBoard()
                case 1:
                    ShopPage()
                default:
                    UserProfilePage()
                }
                
                VStack() {
                    HStack (alignment: .center, spacing: 30) {
                        customTabBar(selectedIndex: $selectedIndex)
                    }.padding()
                }
                Spacer()
            }
		}.background(Color.linearColor)
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}

struct RecentMatches: View {
    
    @StateObject var sectionProgress = HomeSection()
    
    var body: some View {
        VStack(spacing: 10) {
			let categoryDataImages: [String] = ["playerVirat", "playerJoeRoot", "playerBabar", "playerSteveSmith", "playerKaneWill"]
            
			if (sectionProgress.index == 0) {
				ForEach(Array(categoryDataImages.enumerated()), id: \.offset) { index, category in
					HStack {
						RecentMatchesView()
							.shadow(color: Color.black, radius: 5)
					}
				}
				
            } else if (sectionProgress.index == 1) {
                Text("<<< Hello 1>>>")
            } else if (sectionProgress.index == 2) {
				VStack {
					FeaturedPlayersSectionView()
				}
            } else if (sectionProgress.index == 3) {
                Text("<<< Hello 3>>>")
            } else if (sectionProgress.index == 4) {
                Text("<<< Hello 4>>>")
            }
            
        }
        .padding()
    }
}
struct HomeBoard: View {
    
    @StateObject var sectionProgress = HomeSection()
	
	var width = UIScreen.main.bounds.width - 80
    
    var body: some View {
        VStack{
            CardView(featuredSection: true, width:  width , height: 200)
				.clipShape(LiveMatchCard())
				.background(Blur(style: .systemChromeMaterialDark))
				.clipShape(LiveMatchCard())
				.cornerRadius(10, corners: .allCorners)
				.shadow(color: Color.black, radius: 10)
            HomeSections(sectionProgress: sectionProgress)
                    .frame(width: width)
                    .padding(.top, 10)
                    .padding(.bottom, -10)
            ScrollView(showsIndicators: false) {
                VStack(spacing: -20) {
                        RecentMatches(sectionProgress: sectionProgress)
                            .frame(width: UIScreen.main.bounds.width - 30)
                }
            }
            .padding(.top, 10)
            .padding(.bottom, 20)
        }
    }
}

struct HomeSections: View {
	
	@ObservedObject var sectionProgress : HomeSection
	
	var width = UIScreen.main.bounds.width / 7
	var categoryDataImages: [String] = ["clock.fill", "rectangle.fill.on.rectangle.fill", "shared.with.you", "newspaper.fill", "stairs"]
	var categoryDataTitle: [String] = ["Recents", "upcoming", "players", "news", "rankings"]
	
	var body: some View{
		VStack {
			HStack (spacing: 10) {
				ForEach(Array(categoryDataImages.enumerated()), id: \.offset) { index, category in
					let imageName = categoryDataImages[index]
					VStack {
						Image(systemName: imageName)
							.padding()
							.font(.system(size: 25.0))
							.foregroundColor( sectionProgress.index ==	 index ? Color.white : Color.appSecondary)
							.opacity(9)
							.background(Blur(style: .systemChromeMaterialDark))
							.cornerRadius(10, corners: .allCorners)
							.offset(y: CGFloat(-index*5))
							.shadow(color: Color.black, radius: 5)
							.onTapGesture {
								sectionProgress.index = index
						}
					}
				}
			}
		}
	}
}


extension Color {
	static let appSecondary = Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)) // #c49651
	static let appPrimary = Color(#colorLiteral(red: 0.2056267262, green: 0.5325312614, blue: 0.7769566178, alpha: 1))
	static let appBlacks = Color(#colorLiteral(red: 0.03084787726, green: 0.0898687616, blue: 0.1246017292, alpha: 1))
	static let appWhites = Color(red: 0.902, green: 0.906, blue: 0.91) // #e6e7e8
	static let linearColor = LinearGradient(colors: [Color.appPrimary, Color.appPrimary, Color.appPrimary.opacity(0.9)], startPoint: .bottomLeading, endPoint: .topTrailing)
}
