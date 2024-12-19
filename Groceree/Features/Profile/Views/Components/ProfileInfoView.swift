//
//  ProfileInfoView.swift
//  Groceree
//
//  Created by Bindo Thorpe on 19/12/2024.
//
import SwiftUI

struct ProfileInfoView: View {
    
    let user: User
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("PERSOONLIJKE INFORMATIE")
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 24) {
                HStack(spacing: 16) {
                    AsyncImage(url: URL(string: user.imageUrl)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .foregroundColor(.gray.opacity(0.3))
                    }
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    
                    Text(user.firstName)
                        .font(.title3)
                    
                    Spacer()
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(user.bio)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .shadow(radius: 9)
            )
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
    }
    
}
